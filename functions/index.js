const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
admin.initializeApp();

exports.changeSharesCountOnCreate = functions.firestore
    .document("Products/{productID}/sharesUsers/{userId}")
    .onCreate((snap, context) => {
      const productId = context.params.productID;
      return admin.firestore().collection("Products")
          .doc(productId).update({inshares: admin.firestore.FieldValue
              .increment(1)})
          .then(() => {
            console.log("Count is incremented! " + productId);
            return null;
          })
          .catch((error) => {
            console.error("Counter Error writing document: ", error);
            return null;
          });
    });

exports.changeSharesCountOnDelete = functions.firestore
    .document("Products/{productID}/sharesUsers/{userId}")
    .onDelete((snap, context) => {
    // If we set `/users/marie/incoming_messages/134` to {body: "Hello"} then
    // context.params.userId == "marie";
    // context.params.messageCollectionId == "incoming_messages";
    // context.params.messageId == "134";
    // ... and ...
    // change.after.data() == {body: "Hello"}
      const productId = context.params.productID;

      return admin.firestore().collection("Products")
          .doc(productId).update({inshares: admin.firestore.FieldValue
              .increment(-1)})
          .then(() => {
            console.log("Count is incremented! " + productId);
            return null;
          })
          .catch((error) => {
            console.error("Counter Error writing document: ", error);
            return null;
          });
    });
