import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserDetailsFetchedState extends UserState {
  final String userDetails;

  UserDetailsFetchedState({required this.userDetails});

  @override
  List<Object> get props => [userDetails];
}

class UserProfileUpdatedState extends UserState {}

class UserNotificationsFetchedState extends UserState {
  final List<String> notifications;

  UserNotificationsFetchedState({required this.notifications});

  @override
  List<Object> get props => [notifications];
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
