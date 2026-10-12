import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/rooms/domain/usecase/room_use_case.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_state.dart';
import 'package:tatbiqa/feature/sessions/data/model/session_model.dart';

class MockRoomUseCase extends Mock implements RoomUseCase {}

void main() {
  late RoomsCubit cubit;
  late MockRoomUseCase mockRoomUseCase;
  late Directory tempDir;
  late Box<SessionModel> sessionsBox;

  setUpAll(() async {
    tempDir = Directory.systemTemp.createTempSync('tatbiqa_rooms_test');
    Hive.init(tempDir.path);
    final adapter = SessionModelAdapter();
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
    sessionsBox = await Hive.openBox<SessionModel>(HiveBoxes.sessions);
  });

  tearDownAll(() async {
    await Hive.close();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  setUp(() async {
    await sessionsBox.clear();
    mockRoomUseCase = MockRoomUseCase();
    cubit = RoomsCubit(roomUseCase: mockRoomUseCase);
  });

  tearDown(() async {
    await cubit.close();
  });

  final tRoom1 = RoomEntity(
    id: 1,
    name: 'غرفة 1',
    hourlyRate: 50.0,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  final tRoom2 = RoomEntity(
    id: 2,
    name: 'غرفة 2',
    hourlyRate: 70.0,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  test('initial state should be RoomsInitial', () {
    expect(cubit.state, equals(RoomsInitial()));
  });

  group('getRooms', () {
    blocTest<RoomsCubit, RoomsState>(
      'emits [RoomsLoading, RoomsLoaded] with reversed list when rooms exist',
      build: () {
        when(() => mockRoomUseCase.getRooms()).thenAnswer(
          (_) async => Right<Failure, List<RoomEntity>>([tRoom1, tRoom2]),
        );
        return cubit;
      },
      act: (cubit) => cubit.getRooms(),
      expect: () => [
        RoomsLoading(),
        RoomsLoaded(
          [tRoom2, tRoom1],
          {},
          {
            1: {'revenue': 0.0, 'count': 0},
            2: {'revenue': 0.0, 'count': 0},
          },
        ),
      ],
    );

    blocTest<RoomsCubit, RoomsState>(
      'emits [RoomsLoading, RoomsEmpty] when the rooms list is empty',
      build: () {
        when(() => mockRoomUseCase.getRooms()).thenAnswer(
          (_) async => const Right<Failure, List<RoomEntity>>(<RoomEntity>[]),
        );
        return cubit;
      },
      act: (cubit) => cubit.getRooms(),
      expect: () => [RoomsLoading(), RoomsEmpty()],
    );

    blocTest<RoomsCubit, RoomsState>(
      'emits [RoomsLoading, RoomsError] when getRooms fails',
      build: () {
        when(() => mockRoomUseCase.getRooms()).thenAnswer(
          (_) async => Left<Failure, List<RoomEntity>>(
            LocalDatabaseFailure('فشل تحميل الغرف'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.getRooms(),
      expect: () => [RoomsLoading(), const RoomsError('فشل تحميل الغرف')],
    );
  });
}