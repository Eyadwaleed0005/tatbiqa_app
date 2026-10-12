import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/rooms/domain/usecase/room_use_case.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/room_settings_state.dart';

class RoomSettingsCubit extends Cubit<RoomSettingsState> {
  final RoomUseCase roomUseCase;

  RoomSettingsCubit({required this.roomUseCase}) : super(RoomSettingsInitial());

  Future<void> updateRoom({
    required int id,
    required String name,
    required double hourlyRate,
    required DateTime createdAt,
  }) async {
    emit(RoomUpdateLoading());

    final result = await roomUseCase.updateRoom(
      id: id,
      roomName: name,
      hourlyRate: hourlyRate,
      createdAt: createdAt,
    );

    result.fold(
      (failure) => emit(RoomUpdateFailure(failure.message)),
      (success) => emit(RoomUpdateSuccess('تم تحديث الغرفة بنجاح')),
    );
  }

  Future<void> deleteRoom({required int id}) async {
    emit(RoomDeleteLoading()); 

    final result = await roomUseCase.deleteRoom(id: id);

    result.fold(
      (failure) => emit(RoomDeleteFailure(failure.message)),
      (_) => emit(RoomDeleteSuccess('تم حذف الغرفة بنجاح')),
    );
  }
}