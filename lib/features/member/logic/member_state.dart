import 'package:equatable/equatable.dart';

abstract class MemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberLoaded extends MemberState {
  final List<String> members;

  MemberLoaded({required this.members});

  @override
  List<Object?> get props => [members];
}

class MemberError extends MemberState {
  final String message;

  MemberError({required this.message});

  @override
  List<Object?> get props => [message];
}
