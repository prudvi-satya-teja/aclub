import 'package:bloc/bloc.dart';
import 'member_events.dart';
import 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc() : super(MemberInitial()) {
    on<MemberFetchRequested>((event, emit) async {
      emit(MemberLoading());
      try {
        // Simulated data fetching; replace with actual service call
        await Future.delayed(const Duration(seconds: 2));
        emit(MemberLoaded(members: ['Member 1', 'Member 2', 'Member 3']));
      } catch (e) {
        emit(MemberError(message: e.toString()));
      }
    });
  }
}
