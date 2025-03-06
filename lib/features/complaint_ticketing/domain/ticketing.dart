import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:isp_app/features/complaint_ticketing/domain/category.dart';
import 'package:isp_app/features/complaint_ticketing/domain/ticket_status.dart';
import 'package:isp_app/features/order_internet/domain/activity.dart';

class Ticketing extends Equatable {
  final String id;
  final String title;
  final String description;
  final TicketStatus status;
  final Activity activity;
  final TicketCategory category;
  final DateTime startDate;
  final DateTime endDate;

  const Ticketing({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.activity,
    required this.category,
    required this.startDate,
    required this.endDate,
  });

  factory Ticketing.fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Ticketing(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      status: TicketStatus.values
          .firstWhere((element) => element.name == data['status']),
      activity: Activity.fromMap(data['activity']),
      category: TicketCategory.values
          .firstWhere((element) => element.name == data['category']),
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status.name,
      'activity': activity.toMap(),
      'category': category.name,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        activity,
        category,
        startDate,
        endDate,
      ];
}
