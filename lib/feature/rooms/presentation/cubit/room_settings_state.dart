import 'package:equatable/equatable.dart';

sealed class RoomSettingsState extends Equatable {}

class RoomSettingsInitial extends RoomSettingsState {
  @override
  List<Object?> get props => [];
}

class RoomUpdateLoading extends RoomSettingsState {
  @override
  List<Object?> get props => [];
}

class RoomUpdateSuccess extends RoomSettingsState {
  final String message;
  RoomUpdateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RoomUpdateFailure extends RoomSettingsState {
  final String error;
  RoomUpdateFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class RoomDeleteLoading extends RoomSettingsState {
  @override
  List<Object?> get props => [];
}

class RoomDeleteSuccess extends RoomSettingsState {
  final String message;
  RoomDeleteSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RoomDeleteFailure extends RoomSettingsState {
  final String error;
  RoomDeleteFailure(this.error);

  @override
  List<Object?> get props => [error];
}