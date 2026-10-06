import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/usecase/session_use_case.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_state.dart';

class MockSessionUseCase extends Mock implements SessionUseCase {}

void main() {
  late SessionsCubit cubit;
  late MockSessionUseCase mockSessionUseCase;

  setUp(() {
    mockSessionUseCase = MockSessionUseCase();
    cubit = SessionsCubit(mockSessionUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  final tCreatedAt = DateTime(2026);

  final tSessionEntity = SessionEntity(
    id: 1,
    roomId: 1,
    roomName: 'غرفة 1',
    hourlyRate: 50.0,
    startTime: tCreatedAt,
productsCost: 0.0,
    playstationCost: 0.0, 
    totalCost: 0.0,   
    status: 'active',    
    createdAt: tCreatedAt,  );

  test('initial state should be SessionsInitial', () {
    expect(cubit.state, equals(SessionsInitial()));
  });

  group('startSession', () {
    void mockStart(Either<Failure, SessionEntity> result) {
      when(
        () => mockSessionUseCase.startSession(
          roomId: any(named: 'roomId'),
          roomName: any(named: 'roomName'),
          hourlyRate: any(named: 'hourlyRate'),
        ),
      ).thenAnswer((_) async => result);
    }

    blocTest<SessionsCubit, SessionsState>(
      'emits [SessionsLoading, SessionStartedSuccess] when startSession succeeds',
      build: () {
        mockStart(Right(tSessionEntity));
        return cubit;
      },
      act: (cubit) => cubit.startSession(
        roomId: 1,
        roomName: 'غرفة 1',
        hourlyRate: 50.0,
      ),
      expect: () => [
        SessionsLoading(),
        SessionStartedSuccess(tSessionEntity),
      ],
    );

    blocTest<SessionsCubit, SessionsState>(
      'emits [SessionsLoading, SessionsError] when startSession fails',
      build: () {
        mockStart(Left(LocalDatabaseFailure('فشل بدء السيشن')));
        return cubit;
      },
      act: (cubit) => cubit.startSession(
        roomId: 1,
        roomName: 'غرفة 1',
        hourlyRate: 50.0,
      ),
      expect: () => [
        SessionsLoading(),
        const SessionsError('فشل بدء السيشن'),
      ],
    );
  });

  group('getSessions', () {
    void mockGet(Either<Failure, List<SessionEntity>> result) {
      when(() => mockSessionUseCase.getSessions()).thenAnswer((_) async => result);
    }

    blocTest<SessionsCubit, SessionsState>(
      'emits [SessionsLoading, FetchSessionsSuccess] when getSessions succeeds',
      build: () {
        mockGet(Right([tSessionEntity]));
        return cubit;
      },
      act: (cubit) => cubit.getSessions(),
      expect: () => [
        SessionsLoading(),
        FetchSessionsSuccess([tSessionEntity]),
      ],
    );

    blocTest<SessionsCubit, SessionsState>(
      'emits [SessionsLoading, SessionsError] when getSessions fails',
      build: () {
        mockGet(Left(LocalDatabaseFailure('فشل جلب السيشنات')));
        return cubit;
      },
      act: (cubit) => cubit.getSessions(),
      expect: () => [
        SessionsLoading(),
        const SessionsError('فشل جلب السيشنات'),
      ],
    );
  });

  group('endSession', () {
    void mockEnd(Either<Failure, SessionEntity> result) {
      when(
        () => mockSessionUseCase.endSession(
          sessionId: any(named: 'sessionId'),
          playstationCost: any(named: 'playstationCost'),
          productsCost: any(named: 'productsCost'),
          totalCost: any(named: 'totalCost'),
          durationMinutes: any(named: 'durationMinutes'),
        ),
      ).thenAnswer((_) async => result);
    }

    blocTest<SessionsCubit, SessionsState>(
      'emits [SessionsLoading, SessionCheckoutSuccess] when endSession succeeds',
      build: () {
        mockEnd(Right(tSessionEntity));
        return cubit;
      },
      act: (cubit) => cubit.endSession(
        sessionId: 1,
        playstationCost: 50.0,
        productsCost: 20.0,
        totalCost: 70.0,
        durationMinutes: 60,
      ),
      expect: () => [
        SessionsLoading(),
        SessionCheckoutSuccess(tSessionEntity),
      ],
    );

    blocTest<SessionsCubit, SessionsState>(
      'emits [SessionsLoading, SessionsError] when endSession fails',
      build: () {
        mockEnd(Left(LocalDatabaseFailure('فشل إنهاء السيشن')));
        return cubit;
      },
      act: (cubit) => cubit.endSession(
        sessionId: 1,
        playstationCost: 50.0,
        productsCost: 20.0,
        totalCost: 70.0,
        durationMinutes: 60,
      ),
      expect: () => [
        SessionsLoading(),
        const SessionsError('فشل إنهاء السيشن'),
      ],
    );
  });
}