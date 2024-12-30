import 'package:equatable/equatable.dart';
import '../data/club_model.dart';

abstract class ClubsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ClubsInitialState extends ClubsState {}

class ClubsLoadingState extends ClubsState {}

class ClubsLoadedState extends ClubsState {
  final List<Club> clubs;

  ClubsLoadedState({required this.clubs});

  @override
  List<Object?> get props => [clubs];
}

class ClubDetailsLoadedState extends ClubsState {
  final Club club;

  ClubDetailsLoadedState({required this.club});

  @override
  List<Object?> get props => [club];
}

class ClubsErrorState extends ClubsState {
  final String message;

  ClubsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
