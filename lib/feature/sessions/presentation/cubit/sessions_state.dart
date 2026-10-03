import 'package:equatable/equatable.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';

abstract class SessionsState extends Equatable {
  const SessionsState();

  @override
  List<Object?> get props => [];
}

class SessionsInitial extends SessionsState {}

class SessionsLoading extends SessionsState {}

class SessionStartedSuccess extends SessionsState {
  final SessionEntity session;

  const SessionStartedSuccess(this.session);

  @override
  List<Object?> get props => [session];
}

class FetchSessionsSuccess extends SessionsState {
  final List<SessionEntity> sessions;

  const FetchSessionsSuccess(this.sessions);

  @override
  List<Object?> get props => [sessions];
}


class SessionsError extends SessionsState {
  final String message;

  const SessionsError(this.message);

  @override
  List<Object?> get props => [message];
}