import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/usecase/session_product_usecase.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_state.dart';

class MockSessionProductUseCase extends Mock implements SessionProductUseCase {}

void main() {
  late SessionProductCubit cubit;
  late MockSessionProductUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSessionProductUseCase();
    cubit = SessionProductCubit(mockUseCase); 
  });

  tearDown(() {
    cubit.close();
  });

  final tSessionProduct = SessionProductEntity(
    id: 1,
    sessionId: 1,
    productId: 1,
    productName: 'مياه غازية',
    unitPrice: 15.0,
    quantity: 2,
    totalPrice: 30.0,
    createdAt: DateTime(2026),
  );

  test('initial state should be SessionProductInitial', () {
    expect(cubit.state, equals(SessionProductInitial()));
  });

  group('get/add session products', () {
    blocTest<SessionProductCubit, SessionProductState>(
      'emits [SessionProductLoading, SessionProductSuccess] when operation succeeds',
      build: () {
        when(() => mockUseCase.getSessionProducts(any()))
            .thenAnswer((_) async => Right([tSessionProduct]));
        return cubit;
      },
      act: (cubit) => cubit.getSessionProducts(1), 
      expect: () => [
        SessionProductLoading(),
        SessionProductSuccess([tSessionProduct]),
      ],
    );

    blocTest<SessionProductCubit, SessionProductState>(
      'emits [SessionProductLoading, SessionProductError] when operation fails',
      build: () {
        when(() => mockUseCase.getSessionProducts(any()))
            .thenAnswer((_) async => Left(LocalDatabaseFailure('فشل جلب منتجات السيشن')));
        return cubit;
      },
      act: (cubit) => cubit.getSessionProducts(1),
      expect: () => [
        SessionProductLoading(),
        const SessionProductError('فشل جلب منتجات السيشن'),
      ],
    );
  });
}