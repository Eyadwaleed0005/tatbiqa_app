import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/cafe/domain/entity/cafe_entity.dart';
import 'package:tatbiqa/feature/cafe/domain/usecase/cafe_use_case.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_cubit.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_state.dart';

class MockCafeUseCase extends Mock implements CafeUseCase {}

void main() {
  late CafeCubit cubit;
  late MockCafeUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockCafeUseCase();
    cubit = CafeCubit(cafeUseCase: mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be CafeInitial', () {
    expect(cubit.state, equals(CafeInitial()));
  });

  const tCafeName = 'Elmajwj Cafe';
  const tEmail = 'toka@gmail.com';
  const tOwnerName = 'Toka';
  const tPhone = '01059561322';

  const tCafeEntity = CafeEntity(
    id: 685539,
    cafeName: tCafeName,
    email: tEmail,
    ownerName: tOwnerName,
    phone: tPhone,
  );

  const tFailure = LocalDatabaseFailure('Failed to save cafe');
  const tGetFailure = LocalDatabaseFailure('Failed to get cafe data');

  group('saveCafeInfo tests', () {
    blocTest<CafeCubit, CafeState>(
      'emits [SaveCafeDataLoading, SaveCafeDataSuccess] when saveCafeInfo is successful',
      build: () {
        when(
          () => mockUseCase.saveCafeInfo(
            cafeName: tCafeName,
            email: tEmail,
            ownerName: tOwnerName,
            phone: tPhone,
          ),
        ).thenAnswer((_) async => const Right(tCafeEntity));

        return cubit;
      },
      act: (cubit) => cubit.saveCafeInfo(
        cafeName: tCafeName,
        email: tEmail,
        ownerName: tOwnerName,
        phone: tPhone,
      ),
      expect: () => [
        SaveCafeDataLoading(),
        const SaveCafeDataSuccess(cafeEntity: tCafeEntity),
      ],
    );

    blocTest<CafeCubit, CafeState>(
      'emits [SaveCafeDataLoading, SaveCafeDataError] when saveCafeInfo fails',
      build: () {
        when(
          () => mockUseCase.saveCafeInfo(
            cafeName: tCafeName,
            email: tEmail,
            ownerName: tOwnerName,
            phone: tPhone,
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.saveCafeInfo(
        cafeName: tCafeName,
        email: tEmail,
        ownerName: tOwnerName,
        phone: tPhone,
      ),
      expect: () => [
        SaveCafeDataLoading(),
        const SaveCafeDataError(message: 'Failed to save cafe'),
      ],
    );
  });

  group('getCafeInfo tests', () {
    blocTest<CafeCubit, CafeState>(
      'emits [GetDataCafeLoading, GetDataCafeSuccess] when getCafeInfo is successful',
      build: () {
        when(
          () => mockUseCase.getCafeData(),
        ).thenAnswer((_) async => const Right(tCafeEntity));

        return cubit;
      },
      act: (cubit) => cubit.getCafeInfo(),
      expect: () => [
        GetDataCafeLoading(),
        const GetDataCafeSuccess(cafeEntity: tCafeEntity),
      ],
    );

    blocTest<CafeCubit, CafeState>(
      'emits [GetDataCafeLoading, GetDataCafeError] when getCafeInfo fails',
      build: () {
        when(
          () => mockUseCase.getCafeData(),
        ).thenAnswer((_) async => const Left(tGetFailure));

        return cubit;
      },
      act: (cubit) => cubit.getCafeInfo(),
      expect: () => [
        GetDataCafeLoading(),
        const GetDataCafeError(message: 'Failed to get cafe data'),
      ],
    );
  });
}