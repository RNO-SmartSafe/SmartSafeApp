/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {onRequest} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { onCall } from "firebase-functions/v1/https";
import { error } from "console";

admin.initializeApp();
const fcm = admin.messaging();

exports.checkHealth = functions.https.onCall(async (data, context) => {
    return "The function is online";
});

 exports.sendNotification = functions.https,onCall(async (data, context) => {
    const title = data.title;
    const body = data.body;
    const image = data.image;
    const token = data.token;

    try{
      const payload = {
        token: token,
        notification: {
          title: title,
          body: body,
          image: image,
        },
        data: {
          body: body,
        },
      };

      return fcm.send(payload).then((response) => {
        return {success: true, respoonse: "Succesfully sent message: " + response};
      }).catch((error) => {
        return {error: error};
      });
    } catch(error) {
      throw new functions.https.HttpsError("invalid-argument", "error:" + error);
    }
 });

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
