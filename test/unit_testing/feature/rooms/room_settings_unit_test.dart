import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/rooms/domain/usecase/room_use_case.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/room_settings_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/room_settings_state.dart';

class MockRoomUseCase extends Mock implements RoomUseCase {}

void main() {
  late RoomSettingsCubit cubit;
  late MockRoomUseCase mockRoomUseCase;

  setUp(() {
    mockRoomUseCase = MockRoomUseCase();
    cubit = RoomSettingsCubit(roomUseCase: mockRoomUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  final tCreatedAt = DateTime(2026);

  final tRoomEntity = RoomEntity(
    id: 1,
    name: 'غرفة 1',
    hourlyRate: 50.0,
    createdAt: tCreatedAt,
    updatedAt: tCreatedAt,
  );

  test('initial state should be RoomSettingsInitial', () {
    expect(cubit.state, equals(RoomSettingsInitial()));
  });

  group('updateRoom', () {
    void mockUpdate(Either<Failure, RoomEntity> result) {
      when(
        () => mockRoomUseCase.updateRoom(
          id: any(named: 'id'),
          roomName: any(named: 'roomName'),
          hourlyRate: any(named: 'hourlyRate'),
          createdAt: any(named: 'createdAt'),
        ),
      ).thenAnswer((_) async => result);
    }

    blocTest<RoomSettingsCubit, RoomSettingsState>(
      'emits [RoomUpdateLoading, RoomUpdateSuccess] when update succeeds',
      build: () {
        mockUpdate(Right(tRoomEntity));
        return cubit;
      },
      act: (cubit) => cubit.updateRoom(
        id: 1,
        name: 'غرفة 1',
        hourlyRate: 50.0,
        createdAt: tCreatedAt,
      ),
      expect: () => [
        RoomUpdateLoading(),
         RoomUpdateSuccess('تم تحديث الغرفة بنجاح'),
      ],
    );

    blocTest<RoomSettingsCubit, RoomSettingsState>(
      'emits [RoomUpdateLoading, RoomUpdateFailure] when update fails',
      build: () {
        mockUpdate(Left(LocalDatabaseFailure('اسم الغرفة موجود بالفعل')));
        return cubit;
      },
      act: (cubit) => cubit.updateRoom(
        id: 1,
        name: 'غرفة 1',
        hourlyRate: 50.0,
        createdAt: tCreatedAt,
      ),
      expect: () => [
        RoomUpdateLoading(),
         RoomUpdateFailure('اسم الغرفة موجود بالفعل'),
      ],
    );

   
  });

  group('deleteRoom', () {
    blocTest<RoomSettingsCubit, RoomSettingsState>(
      'emits [RoomDeleteLoading, RoomDeleteSuccess] when delete succeeds',
      build: () {
        when(() => mockRoomUseCase.deleteRoom(id: any(named: 'id')))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) => cubit.deleteRoom(id: 1),
      expect: () => [
        RoomDeleteLoading(),
         RoomDeleteSuccess('تم حذف الغرفة بنجاح'),
      ],
    );

    blocTest<RoomSettingsCubit, RoomSettingsState>(
      'emits [RoomDeleteLoading, RoomDeleteFailure] when delete fails',
      build: () {
        when(() => mockRoomUseCase.deleteRoom(id: any(named: 'id')))
            .thenAnswer((_) async => Left(LocalDatabaseFailure('فشل حذف الغرفة')));
        return cubit;
      },
      act: (cubit) => cubit.deleteRoom(id: 1),
      expect: () => [
        RoomDeleteLoading(),
         RoomDeleteFailure('فشل حذف الغرفة'),
      ],
    );

   
  });
}