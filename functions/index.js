/* eslint-disable quotes */
/* eslint-disable indent */
/* eslint-disable max-len */
// Import the Firebase SDK for Google Cloud Functions.
const functions = require("firebase-functions");
// Import and initialize the Firebase Admin SDK.
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotifications = functions.firestore.document("Date/{date}/Notification/{NotificationId}").onCreate(
  async (snapshot, context) => {
    const currentDate = new Date().toISOString().split("T")[0];
    functions.logger.log("currentDate: ", currentDate);
    functions.logger.log("currentDateParams: ", context.params.date);

    if (context.params.date === currentDate) {
      // const data = snapshot.data();
      const text = snapshot.data().text;
      const name = snapshot.data().name;

      // const text = "Alert is on!";
      // const name = "Employee is not Safe!";
      // functions.logger.log("Document data: ", data);
      functions.logger.log("This is the name: ", name);
      functions.logger.log("This is the text: ", text);

      const payload = {
        notification: {
          title: `${name ? name : "Employee in Danger"}`,
          body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : 'Click to see',
        },
        token: "eD6IrGf5Q6qD6pra8cv_5T:APA91bF6tG3wbt7DoPfGD3A1JPuQv1sa7TDLkei5J2WRqt_eqfjiAGZgZFDFXaik4Tlo2-xjjJhiIGwsQO5JMtan3kyy8FoJyNOncrL3Gew3XWzLvuzVDDjP25bpNREx394GV6yyRMTy", // Replace with your token
      };

      try {
        const response = await admin.messaging().send(payload);
        functions.logger.log('Notification sent successfully:', response);
      } catch (error) {
        functions.logger.error('Error sending notification:', error);
      }
    }
  });

