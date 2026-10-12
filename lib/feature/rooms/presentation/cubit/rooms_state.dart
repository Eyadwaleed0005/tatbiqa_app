import 'package:equatable/equatable.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';

sealed class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object?> get props => [];
}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsLoaded extends RoomsState {
  final List<RoomEntity> rooms;
  final Map<int, SessionEntity> activeSessionsMap;

  final Map<int, Map<String, dynamic>> roomsStatsMap;

  const RoomsLoaded(this.rooms, this.activeSessionsMap, this.roomsStatsMap);

  @override
  List<Object?> get props => [rooms, roomsStatsMap, activeSessionsMap];
}

class RoomsEmpty extends RoomsState {}

class RoomsError extends RoomsState {
  final String errMessage;

  const RoomsError(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
