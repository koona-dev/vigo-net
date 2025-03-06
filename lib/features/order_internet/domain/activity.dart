import 'package:equatable/equatable.dart';
import 'package:isp_app/features/order_internet/domain/activity_states/activity_status.dart';

class Activity extends Equatable {
  final String id;
  final String title;
  final String description;
  final ActivityStatus status;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [id, title, description, status];

  factory Activity.fromMap(Map<String, dynamic> data) {
    return Activity(
      id: data['title'] ?? '',
      title: data['title'] ?? '',
      description: data['deskripsi'] ?? '',
      status: ActivityStatus.values
          .firstWhere((status) => status.name == data['status']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
    };
  }
}
