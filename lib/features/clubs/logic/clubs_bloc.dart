import 'package:flutter_bloc/flutter_bloc.dart';
import 'clubs_events.dart';
import 'clubs_state.dart';
import '../data/club_repository.dart';

class ClubsBloc extends Bloc<ClubsEvent, ClubsState> {
  final ClubRepository clubRepository;

  ClubsBloc({required this.clubRepository}) : super(ClubsInitialState()) {
    on<FetchClubsEvent>(_onFetchClubs);
    on<FetchClubDetailsEvent>(_onFetchClubDetails);
  }

  Future<void> _onFetchClubs(
      FetchClubsEvent event, Emitter<ClubsState> emit) async {
    emit(ClubsLoadingState());
    try {
      final clubs = await clubRepository.fetchClubs();
      emit(ClubsLoadedState(clubs: clubs));
    } catch (e) {
      emit(ClubsErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchClubDetails(
      FetchClubDetailsEvent event, Emitter<ClubsState> emit) async {
    emit(ClubsLoadingState());
    try {
      final clubDetails = await clubRepository.fetchClubDetails(event.clubId);
      emit(ClubDetailsLoadedState(club: clubDetails));
    } catch (e) {
      emit(ClubsErrorState(message: e.toString()));
    }
  }
}
