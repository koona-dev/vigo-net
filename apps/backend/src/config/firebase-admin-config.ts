/*
 ** PACKAGES NODE MODULES
 */
import admin from "firebase-admin";

import serviceAccount from "../../vigo-net-firebase-adminsdk.json";

// configuration firebase admin
const firebase = admin.apps.length
  ? admin.app()
  : admin.initializeApp({
      credential: admin.credential.cert(
        JSON.parse(JSON.stringify(serviceAccount))
      ),
    });

/*
 ** DECLARE ALL PRODUCT FIREBASE
 */
export const firebaseAuth = firebase.auth();
export const firestore = firebase.firestore();
export const firebaseStorage = firebase.storage();
export const cloudMsg = firebase.messaging();
export const firebaseRealtimeDB = firebase.database();
