import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_events.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // Simulate authentication API call
        await Future.delayed(const Duration(seconds: 2));
        if (event.email == "test@example.com" && event.password == "password") {
          emit(AuthSuccess(userId: "12345", email: event.email));
        } else {
          emit(AuthFailure(message: "Invalid credentials"));
        }
      } catch (error) {
        emit(AuthFailure(message: error.toString()));
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // Simulate signup API call
        await Future.delayed(const Duration(seconds: 2));
        emit(AuthSuccess(userId: "54321", email: event.email));
      } catch (error) {
        emit(AuthFailure(message: error.toString()));
      }
    });

    on<LogoutEvent>((event, emit) {
      emit(AuthInitial());
    });
  }
}
