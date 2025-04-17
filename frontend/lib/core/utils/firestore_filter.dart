import 'package:cloud_firestore/cloud_firestore.dart';

Query getFilteredQuery(String collection, Map<String, dynamic> filters) {
  Query query = FirebaseFirestore.instance.collection(collection);

  filters.forEach((key, value) {
    if (value is Map<String, dynamic>) {
      // Handle special conditions like isEqualTo, isGreaterThan, etc.
      value.forEach((operator, filterValue) {
        if (operator == "isEqualTo") {
          query = query.where(key, isEqualTo: filterValue);
        } else if (operator == "isNotEqualTo") {
          query = query.where(key, isNotEqualTo: filterValue);
        } else if (operator == "isGreaterThan") {
          query = query.where(key, isGreaterThan: filterValue);
        } else if (operator == "isLessThan") {
          query = query.where(key, isLessThan: filterValue);
        } else if (operator == "arrayContains") {
          query = query.where(key, arrayContains: filterValue);
        } else if (operator == "whereIn") {
          query = query.where(key, whereIn: filterValue);
        }
      });
    } else {
      // Default to isEqualTo if no operator is provided
      query = query.where(key, isEqualTo: value);
    }
  });

  return query;
}
