import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_events.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<FetchDashboardData>((event, emit) async {
      emit(AdminLoading());
      try {
        // Simulate API call or data fetching
        await Future.delayed(const Duration(seconds: 2));
        emit(AdminDashboardDataLoaded(dashboardData: "Sample Dashboard Data"));
      } catch (error) {
        emit(AdminError(message: error.toString()));
      }
    });

    on<ManageUsersEvent>((event, emit) {
      // Handle user management events
      emit(AdminUserManagementState(status: "User Management Successful"));
    });

    on<ManageClubsEvent>((event, emit) {
      // Handle club management events
      emit(AdminClubManagementState(status: "Club Management Successful"));
    });
  }
}
