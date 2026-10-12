import 'package:equatable/equatable.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';

sealed class AddRoomState extends Equatable {
  const AddRoomState();

  @override
  List<Object?> get props => [];
}

class AddRoomInitial extends AddRoomState {}

class AddRoomLoading extends AddRoomState {}

class AddRoomSuccess extends AddRoomState {
  final RoomEntity room;

  const AddRoomSuccess(this.room);

  @override
  List<Object?> get props => [room];
}

class AddRoomFailure extends AddRoomState {
  final String errMessage;

  const AddRoomFailure(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}