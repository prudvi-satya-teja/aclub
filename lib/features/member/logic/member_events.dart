import 'package:equatable/equatable.dart';

abstract class MemberEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MemberFetchRequested extends MemberEvent {}
