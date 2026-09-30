import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/rooms/domain/usecase/room_use_case.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final RoomUseCase roomUseCase;

  RoomsCubit({required this.roomUseCase}) : super(RoomsInitial());

  Future<void> getRooms() async {
    emit(RoomsLoading());

    final result = await roomUseCase.getRooms();

    result.fold((failure) => emit(RoomsError(failure.message)), (rooms) {
      if (rooms.isEmpty) {
        emit(RoomsEmpty());
      } else {
        final sortedRooms = rooms.reversed.toList();
        emit(RoomsLoaded(sortedRooms));
      }
    });
  }
}
