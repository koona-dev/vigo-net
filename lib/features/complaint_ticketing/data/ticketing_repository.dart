import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isp_app/features/complaint_ticketing/domain/ticket_status.dart';
import 'package:isp_app/features/complaint_ticketing/domain/ticketing.dart';

class TicketingRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<List<Ticketing?>> getAllTicketingByUser() async {
    final ticketingCol = await firestore.collection('ticketing').get();
    final ticketingData = ticketingCol.docs.map((doc) {
      if (doc.data()['userId'] == currentUser.uid) {
        return Ticketing.fromMap(id: doc.id, data: doc.data());
      }
    }).toList();
    return ticketingData;
  }

  Future<Ticketing> getTicketingById(String ticketId) async {
    final ticketDoc =
        await firestore.collection('ticketing').doc(ticketId).get();
    return Ticketing.fromMap(id: ticketDoc.id, data: ticketDoc.data()!);
  }

  void createTicketing(Ticketing ticket) async {
    try {
      await firestore.collection('ticketing').doc().set(ticket.toMap());
    } catch (e) {
      print(e);
    }
  }

  void updateActivityTicket(Ticketing ticket) async {
    await firestore
        .collection('ticketing')
        .doc(currentUser.uid)
        .update(ticket.toMap());
  }

  void updateTicketStatus() async {
    try {
      await firestore.collection('ticketing').snapshots().map((value) {
        return value.docs.map((doc) {
          final activity = doc['activity'] as Map<String, dynamic>;
          final activityStatus = activity['id'] as String;
          if (activityStatus == TicketStatus.berhasil) {
            doc.reference.update({'status': TicketStatus.berhasil});
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteTicketing(String ticketId) async {
    try {
      await firestore.collection('ticketing').doc(ticketId).delete();
    } catch (e) {
      print(e);
    }
  }
}
