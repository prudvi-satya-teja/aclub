import 'package:equatable/equatable.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminDashboardDataLoaded extends AdminState {
  final String dashboardData;

  const AdminDashboardDataLoaded({required this.dashboardData});

  @override
  List<Object?> get props => [dashboardData];
}

class AdminError extends AdminState {
  final String message;

  const AdminError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AdminUserManagementState extends AdminState {
  final String status;

  const AdminUserManagementState({required this.status});

  @override
  List<Object?> get props => [status];
}

class AdminClubManagementState extends AdminState {
  final String status;

  const AdminClubManagementState({required this.status});

  @override
  List<Object?> get props => [status];
}
