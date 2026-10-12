import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/rooms/domain/usecase/room_use_case.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/add_room_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/add_room_state.dart';

class MockRoomUseCase extends Mock implements RoomUseCase {}

void main() {
  late AddRoomCubit addRoomCubit;
  late MockRoomUseCase mockRoomUseCase;

  setUp(() {
    mockRoomUseCase = MockRoomUseCase();
    addRoomCubit = AddRoomCubit(addRoomUseCase: mockRoomUseCase);
  });

  tearDown(() {
    addRoomCubit.close();
  });

  final tRoomEntity = RoomEntity(
    id: 1,
    name: 'غرفة 1',
    hourlyRate: 50.0,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  test('initial state should be AddRoomInitial', () {
    expect(addRoomCubit.state, equals(AddRoomInitial()));
  });

  blocTest<AddRoomCubit, AddRoomState>(
    'emits [AddRoomLoading, AddRoomSuccess] when addRoom is successful',
    build: () {
      when(() => mockRoomUseCase.addRoom(name: any(named: 'name'), hourlyRate: any(named: 'hourlyRate')))
          .thenAnswer((_) async => Right(tRoomEntity));
      return addRoomCubit;
    },
    act: (cubit) => cubit.addRoom(name: 'غرفة 1', hourlyRate: 50.0),
    expect: () => [
      AddRoomLoading(),
      AddRoomSuccess(tRoomEntity),
    ],
  );
  blocTest<AddRoomCubit, AddRoomState>(
    'emits [AddRoomLoading, AddRoomFailure] when addRoom fails',
    build: () {
      when(() => mockRoomUseCase.addRoom(name: any(named: 'name'), hourlyRate: any(named: 'hourlyRate')))
          .thenAnswer((_) async => Left(LocalDatabaseFailure('اسم الغرفة موجود بالفعل')));
      return addRoomCubit;
    },
    act: (cubit) => cubit.addRoom(name: 'غرفة 1', hourlyRate: 50.0),
    expect: () => [
      AddRoomLoading(),
      const AddRoomFailure('اسم الغرفة موجود بالفعل'),
    ],
  );
}