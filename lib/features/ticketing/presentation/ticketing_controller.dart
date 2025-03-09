import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/core/utils/firestore_filter.dart';
import 'package:isp_app/features/ticketing/data/ticketing_repository.dart';
import 'package:isp_app/features/ticketing/domain/category.dart';
import 'package:isp_app/features/ticketing/domain/ticketing.dart';

final ticketingControllerProvider = Provider.autoDispose((ref) {
  return TicketingController(
    ref: ref,
  );
});

final findOneTicketProvider =
    FutureProvider.family.autoDispose<Ticketing, String>((ref, ticketId) {
  final ticketController = ref.watch(ticketingControllerProvider);
  return ticketController.findOneTicket(ticketId);
});

final findOneTicketOrderProvider =
    FutureProvider.family.autoDispose<Ticketing, String>((ref, userId) {
  final ticketController = ref.watch(ticketingControllerProvider);
  return ticketController.findOneTicketOrder(userId);
});

final getAllTicketingProvider =
    StreamProvider.family.autoDispose<List<Ticketing?>, String>((ref, userId) {
  final ticketController = ref.watch(ticketingControllerProvider);
  return ticketController.getAllTicketingByUser(userId);
});

class TicketingController {
  final Ref ref;
  TicketingController({
    required this.ref,
  });

  final _ticketingRepository = TicketingRepository();

  Future<Ticketing> findOneTicket(String ticketId) async {
    final filter = getFilteredQuery('ticketing', {
      'id': {'isEqualTo': ticketId},
    });
    return await _ticketingRepository.findOne(filter);
  }

  Future<Ticketing> findOneTicketOrder(
    String userId,
  ) async {
    final filter = getFilteredQuery('ticketing', {
      'id': {'isEqualTo': userId},
      'category': {'isEqualTo': TicketCategory.pemesanan.name},
    });
    return await _ticketingRepository.findOne(filter);
  }

  Stream<List<Ticketing>> getAllTicketingByUser(String userId) {
    final filter = getFilteredQuery('ticketing', {
      'userId': {'isEqualTo': userId},
      'category': {'isNotEqualTo': TicketCategory.pemesanan.name},
    });
    return _ticketingRepository.getAll(filter);
  }

  void createTicketing(Ticketing ticket) {
    _ticketingRepository.create(ticket);
  }

  void updateActivityTicket(Ticketing ticket) {
    final filter = getFilteredQuery('ticketing', {
      'userId': {'isEqualTo': ticket.id}
    });
    _ticketingRepository.update(filter, ticket);
  }

  void cancelTicketing(String orderId) {
    _ticketingRepository.delete(orderId);
  }
}
