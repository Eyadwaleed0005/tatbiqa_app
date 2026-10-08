import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/products/domain/usecase/products_usecase.dart';
import 'package:tatbiqa/feature/products/presentation/cubit/products_cubit.dart';

class MockProductsUseCase extends Mock implements ProductsUseCase {}

void main() {
  late ProductsCubit cubit;
  late MockProductsUseCase mockProductsUseCase;

  setUp(() {
    mockProductsUseCase = MockProductsUseCase();
    cubit = ProductsCubit(products: mockProductsUseCase);
  });

  tearDown(() {
    cubit.close();
  });

   final tProductEntity = ProductEntity(
    id: 1,
    name: 'Coffee',
    price: 50.0,
    isAvailable: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  const tFailure = LocalDatabaseFailure('Error occurred');

  group('ProductsCubit - Fetch Products', () {
    test('initial state should be ProductsInitial', () {
      expect(cubit.state, equals(ProductsInitial()));
    });

    blocTest<ProductsCubit, ProductsState>(
      'emits [ProductsLoading, ProductsSuccess] when fetchProdcts is successful',
      build: () {
        when(
          () => mockProductsUseCase.getProducts(),
        ).thenAnswer((_) async =>  Right([tProductEntity]));
        return cubit;
      },
      act: (cubit) => cubit.fetchProdcts(),
      expect: () => [
        ProductsLoading(),
         ProductsSuccess(productEntity: [tProductEntity]),
      ],
    );

    blocTest<ProductsCubit, ProductsState>(
      'emits [ProductsLoading, ProductsFailure] when fetchProdcts fails',
      build: () {
        when(
          () => mockProductsUseCase.getProducts(),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.fetchProdcts(),
      expect: () => [
        ProductsLoading(),
         ProductsFailure(error: tFailure.message),
      ],
    );
  });
}