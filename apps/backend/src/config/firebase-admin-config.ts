/* 
** PACKAGES NODE MODULES
*/
import admin from "firebase-admin";

import serviceAccount from "../../vigo-net-firebase-adminsdk.json";

// configuration firebase admin
admin.initializeApp({
  credential: admin.credential.cert(JSON.parse(JSON.stringify(serviceAccount))),
});

/* 
** DECLARE ALL PRODUCT FIREBASE
*/
export const firebaseAuth = admin.auth();
export const firestore = admin.firestore();
export const firebaseStorage = admin.storage();
export const cloudMsg = admin.messaging();
export const firebaseRealtimeDB = admin.database();

