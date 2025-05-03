import 'package:equatable/equatable.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/activity_states/activity_status.dart';

class Activity extends Equatable {
  final String title;
  final String description;
  final ActivityStatus status;
  final String flag;

  Activity({
    required this.title,
    required this.description,
    required this.status,
    required this.flag,
  });

  @override
  List<Object?> get props => [title, description, status];

  factory Activity.fromMap(Map<String, dynamic> data) {
    return Activity(
      title: data['title'],
      description: data['description'],
      status: ActivityStatus.values
          .firstWhere((status) => status.name == data['status']),
      flag: data['flag'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status.name,
      'flag': flag,
    };
  }
}
