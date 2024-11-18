/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
const functions = require("firebase-functions");
const admin = require("firebase-admin");

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Initialize Firebase Admin SDK
admin.initializeApp();

exports.deleteDriverAccount = functions.https.onCall(async (data, context) => {
  const email = data.email;

  if (!email) {
    throw new functions.https.HttpsError(
        "invalid-argument",
        "The email address is required to delete the account.",
    );
  }

  try {
    // Get the user by email
    const user = await admin.auth().getUserByEmail(email);

    // Delete the user account
    await admin.auth().deleteUser(user.uid);

    return {message: "Driver account deleted successfully."};
  } catch (error) {
    console.error("Error deleting user:", error);
    throw new functions.https.HttpsError(
        "internal",
        "An error occurred while deleting the driver account: " + error.message,
    );
  }
});
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
