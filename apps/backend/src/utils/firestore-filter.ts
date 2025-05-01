import { firestore } from "../config/firebase-admin-config";

export default function getFilteredQuery(
  collection: string,
  filters?: { [key: string]: any }[]
) {
  const userRepo = firestore.collection(collection);

  if (filters) {
    filters.forEach((filter) => {
      userRepo.where(filter.field, filter.operator, filter.value);
    });
  }

  return userRepo;
}
