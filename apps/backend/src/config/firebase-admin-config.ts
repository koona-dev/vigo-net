import admin from "firebase-admin";

import serviceAccount from "../../vigo-net-firebase-adminsdk.json";

admin.initializeApp({
  credential: admin.credential.cert(JSON.parse(JSON.stringify(serviceAccount))),
});

export const firestore = admin.firestore();
