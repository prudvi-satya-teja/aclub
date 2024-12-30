import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class FetchDashboardData extends AdminEvent {}

class ManageUsersEvent extends AdminEvent {
  final String userId;
  const ManageUsersEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class ManageClubsEvent extends AdminEvent {
  final String clubId;
  const ManageClubsEvent(this.clubId);

  @override
  List<Object> get props => [clubId];
}
