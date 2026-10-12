import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/rooms/domain/usecase/room_use_case.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/add_room_state.dart';

class AddRoomCubit extends Cubit<AddRoomState> {
  final RoomUseCase addRoomUseCase;

  AddRoomCubit( {required this.addRoomUseCase}) : super(AddRoomInitial());

  Future<void> addRoom({
    required String name,
    required double hourlyRate,
  }) async {
    emit(AddRoomLoading());

    final result = await addRoomUseCase.addRoom(
      name: name,
      hourlyRate: hourlyRate,
    );

    result.fold(
      (failure) => emit(AddRoomFailure( failure.message)),
      (roomEntity) => emit(AddRoomSuccess( roomEntity)),
    );
  }
}