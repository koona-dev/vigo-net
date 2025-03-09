import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:isp_app/features/ticketing/domain/category.dart';
import 'package:isp_app/features/ticketing/domain/ticket_status.dart';
import 'package:isp_app/features/ticketing/domain/activity.dart';

class Ticketing extends Equatable {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final TicketStatus status;
  final Activity activity;
  final TicketCategory category;
  final DateTime startDate;
  final DateTime endDate;

  const Ticketing({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
    required this.activity,
    required this.category,
    required this.startDate,
    required this.endDate,
  });

  factory Ticketing.fromMap(
    Map<String, dynamic> data,
  ) {
    return Ticketing(
      id: data['id'] ?? '',
      userId: data['userId'],
      title: data['title'],
      description: data['description'],
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
      'userId': userId,
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
        userId,
        title,
        description,
        status,
        activity,
        category,
        startDate,
        endDate,
      ];
}
