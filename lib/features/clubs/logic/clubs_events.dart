import 'package:equatable/equatable.dart';

abstract class ClubsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchClubsEvent extends ClubsEvent {}

class FetchClubDetailsEvent extends ClubsEvent {
  final String clubId;

  FetchClubDetailsEvent({required this.clubId});

  @override
  List<Object?> get props => [clubId];
}
