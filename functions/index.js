// Import the Firebase SDK for Google Cloud Functions.
const functions = require("firebase-functions");
// Import and initialize the Firebase Admin SDK.
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotifications = functions.firestore.document('Date/{date}/Notification/{NotificationId}').onCreate(
  async (snapshot, context) => {
    const currentDate = new Date().toISOString().split('T')[0];
    // Notification details.
    if(context.params.date === currentDate) {
      const text = snapshot.data().text;
      const name = snapshot.data().name;
      functions.logger.log('This is the text: ', name);
      const payload = {
        notification: {
          title: `${name? name : 'Employee in Danger'}`,
          body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : 'Click to see',
        },
        token: "f_YB2w63T8iTMEv1fvXypw:APA91bHb73TFHYCvaQRjiuYC4RW-FhYPzIvb-7x_iYFEUGzK3dnVVR8RLCx3rxN1gabZvDT77U4_YFhMu2cM39yH4cE4H84QO-IqIpSbGLnSN28YNWTU44JA1L7RmJqKfUPdiLFcHgO",
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
    }
  });
