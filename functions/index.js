// Import the Firebase SDK for Google Cloud Functions.
const functions = require('firebase-functions');
// Import and initialize the Firebase Admin SDK.
const admin = require('firebase-admin');
admin.initializeApp();

exports.addWelcomeMessages = functions.auth.user().onCreate(async (user) => {
  functions.logger.log('A new user signed in for the first time.');
  const fullName = user.displayName || 'Anonymous';

  // Saves the new welcome message into the database
  // which then displays it in the FriendlyChat clients.
  await admin.firestore().collection('messages').add({
    name: 'Firebase Bot',
    text: `${fullName} signed in for the first time! Welcome!`,
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  });
  functions.logger.log('Welcome message written to database.');
});

exports.sendNotifications = functions.firestore.document('messages/{messageId}').onCreate(
  async (snapshot) => {
    // Notification details.
    const text = snapshot.data().text;
    const name = snapshot.data().name;
    functions.logger.log('This is the text: ', text);
    const payload = {
      // notification: {
        // title: `${snapshot.data().name} posted ${text ? 'a message' : 'an image'}`,
      //   body: text ? (text.length <= 100 ? {text} : text.substring(0, 97) + '...') : 'blabla'
      // },
      notification: {
        title: `${name}`,
        body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : 'blabla',
      },
      token: "exZk7852Txy6GtAvh0ii55:APA91bEYn8x1HLCivK2QhoLh4fu_WWOci5PIalksq3CP9Q4gy3k12QpvG-AB73N1q5A2SmrBlxZYgjOyJzn_FBDzMfv7GwS1e7kKJHeqnv25ict5h8kX-uZ5EmREqriiCyAPl0gFXhdd",
    };

    // Get the list of device tokens.
    const allTokens = await admin.firestore().collection('fcmTokens').get();
    const tokens = [];
    allTokens.forEach((tokenDoc) => {
      tokens.push(tokenDoc.id);
    });

    if (tokens.length > 0) {
      // Send notifications to all tokens.
      functions.logger.log('This is the payload: ', payload);
      functions.logger.log('Those are the tokens ', tokens);
      await admin.messaging().send(payload);
      // await cleanupTokens(response, tokens);
      functions.logger.log('Notifications have been sent and tokens cleaned up.');
    }
  });

  // Cleans up the tokens that are no longer valid.
function cleanupTokens(response, tokens) {
  // For each notification we check if there was an error.
  const tokensDelete = [];
  response.results.forEach((result, index) => {
    const error = result.error;
    if (error) {
      functions.logger.error('Failure sending notification to', tokens[index], error);
      // Cleanup the tokens that are not registered anymore.
      if (error.code === 'messaging/invalid-registration-token' ||
          error.code === 'messaging/registration-token-not-registered') {
        const deleteTask = admin.firestore().collection('fcmTokens').doc(tokens[index]).delete();
        tokensDelete.push(deleteTask);
      }
    }
  });
  return Promise.all(tokensDelete);
 }