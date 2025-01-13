import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_events.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<FetchUserDetailsEvent>(_onFetchUserDetails);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<FetchUserNotificationsEvent>(_onFetchUserNotifications);
  }

  void _onFetchUserDetails(
      FetchUserDetailsEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      // Simulate fetching user data
      await Future.delayed(const Duration(seconds: 2));
      emit(UserDetailsFetchedState(userDetails: "Sample User Details"));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  void _onUpdateUserProfile(
      UpdateUserProfileEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      // Simulate updating user profile
      await Future.delayed(const Duration(seconds: 2));
      emit(UserProfileUpdatedState());
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  void _onFetchUserNotifications(
      FetchUserNotificationsEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      // Simulate fetching notifications
      await Future.delayed(const Duration(seconds: 2));
      emit(UserNotificationsFetchedState(notifications: [
        "Notification 1",
        "Notification 2",
        "Notification 3",
      ]));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }
}
