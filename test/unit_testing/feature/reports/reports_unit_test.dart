import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/reports/domain/entity/reports_entity.dart';
import 'package:tatbiqa/feature/reports/domain/usecase/reports_usecase.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/reports_cubit.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/reports_state.dart';

class MockReportsUseCase extends Mock implements ReportsUseCase {}

void main() {
  late ReportsCubit cubit;
  late MockReportsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockReportsUseCase();
    cubit = ReportsCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be ReportsInitial', () {
    expect(cubit.state, equals(ReportsInitial()));
  });

  final tDate = DateTime(2026, 10, 8);
  const tYear = 2026;
  const tMonth = 10;

  const tReportsEntity = ReportsEntity(
    totalIncome: 1500.0,
    playstationIncome: 1000.0,
    productsIncome: 500.0,
    totalSessionsCount: 12,
    totalPlayMinutes: 360,
    topRoomByRevenue: "غرفة 1",
    leastRoomByRevenue: "غرفة 3",
    topRoomByTime: "غرفة 1",
    leastRoomByTime: "غرفة 3",
    roomsPerformance: []
  );

  const tFailure = LocalDatabaseFailure('Failed to get report');

  group('fetchDailyReport tests', () {
    blocTest<ReportsCubit, ReportsState>(
      'emits [ReportsLoading, ReportsLoaded] when fetchDailyReport is successful',
      build: () {
        when(() => mockUseCase.getDailyReport(tDate))
            .thenAnswer((_) async => const Right(tReportsEntity));
        return cubit;
      },
      act: (cubit) => cubit.fetchDailyReport(tDate),
      expect: () => [
        ReportsLoading(),
        const ReportsLoaded(tReportsEntity),
      ],
    );

    blocTest<ReportsCubit, ReportsState>(
      'emits [ReportsLoading, ReportsError] when fetchDailyReport fails',
      build: () {
        when(() => mockUseCase.getDailyReport(tDate))
            .thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.fetchDailyReport(tDate),
      expect: () => [
        ReportsLoading(),
        const ReportsError('Failed to get report'),
      ],
    );
  });

  group('fetchMonthlyReport tests', () {
    blocTest<ReportsCubit, ReportsState>(
      'emits [ReportsLoading, ReportsLoaded] when fetchMonthlyReport is successful',
      build: () {
        when(() => mockUseCase.getMonthlyReport(tYear, tMonth))
            .thenAnswer((_) async => const Right(tReportsEntity));
        return cubit;
      },
      act: (cubit) => cubit.fetchMonthlyReport(tYear, tMonth),
      expect: () => [
        ReportsLoading(),
        const ReportsLoaded(tReportsEntity),
      ],
    );

    blocTest<ReportsCubit, ReportsState>(
      'emits [ReportsLoading, ReportsError] when fetchMonthlyReport fails',
      build: () {
        when(() => mockUseCase.getMonthlyReport(tYear, tMonth))
            .thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.fetchMonthlyReport(tYear, tMonth),
      expect: () => [
        ReportsLoading(),
        const ReportsError('Failed to get report'),
      ],
    );
  });
}