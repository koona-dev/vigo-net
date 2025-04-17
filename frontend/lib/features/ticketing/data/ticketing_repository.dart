import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_app/features/ticketing/domain/ticketing.dart';

class TicketingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Ticketing?> findOne({String? docId, Query? filterQuery}) async {
    try {
      if (docId != null) {
        return await _firestore
            .collection('ticketing')
            .doc(docId)
            .get()
            .then((doc) {
          return Ticketing.fromMap(
              {'id': doc.id, ...doc.data() as Map<String, dynamic>});
        });
      }
      return await filterQuery
          ?.limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        final doc = querySnapshot.docs.first;
        return Ticketing.fromMap(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>});
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Ticketing>> getAll(Query filterQuery) {
    try {
      return filterQuery.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Ticketing.fromMap(
                {'id': doc.id, ...doc.data() as Map<String, dynamic>}))
            .toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> create(Ticketing ticket) async {
    try {
      await _firestore.collection('ticketing').doc().set(ticket.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> update(Query filterQuery, Ticketing data) async {
    try {
      await filterQuery.limit(1).snapshots().first.then((snapshot) {
        final doc = snapshot.docs.first;
        doc.reference.update(data.toMap());
      }); // snapshots()
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await _firestore.collection('ticketing').doc(id).delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
