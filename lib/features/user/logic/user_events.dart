import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserDetailsEvent extends UserEvent {}

class UpdateUserProfileEvent extends UserEvent {
  final String updatedDetails;

  UpdateUserProfileEvent({required this.updatedDetails});

  @override
  List<Object> get props => [updatedDetails];
}

class FetchUserNotificationsEvent extends UserEvent {}
