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

  const tId = 1;
  const tName = 'Coffee Updated';
  const tPrice = 60.0;
  const tIsAvailable = true;
  final  tProductEntity = ProductEntity(
    id: tId,
    name: tName,
    price: tPrice,
    isAvailable: tIsAvailable,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  const tFailure = LocalDatabaseFailure('Error occurred');

  group('ProductsCubit - Update Product', () {
    test('initial state should be ProductsInitial', () {
      expect(cubit.state, equals(ProductsInitial()));
    });

    blocTest<ProductsCubit, ProductsState>(
      'emits [UpdateProductsLoading, UpdateProductsSuccess] when updateProduct is successful',
      build: () {
        when(
          () => mockProductsUseCase.updateProduct(
            id: tId,
            name: tName,
            price: tPrice,
            isAvailable: tIsAvailable,
          ),
        ).thenAnswer((_) async =>  Right(tProductEntity));
        return cubit;
      },
      act: (cubit) => cubit.updateProduct(
        id: tId,
        name: tName,
        price: tPrice,
        isAvailable: tIsAvailable,
      ),
      expect: () => [
        UpdateProductsLoading(),
         UpdateProductsSuccess(products: tProductEntity),
      ],
    );

    blocTest<ProductsCubit, ProductsState>(
      'emits [UpdateProductsLoading, UpdateProductsFailure] when updateProduct fails',
      build: () {
        when(
          () => mockProductsUseCase.updateProduct(
            id: tId,
            name: tName,
            price: tPrice,
            isAvailable: tIsAvailable,
          ),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.updateProduct(
        id: tId,
        name: tName,
        price: tPrice,
        isAvailable: tIsAvailable,
      ),
      expect: () => [
        UpdateProductsLoading(),
         UpdateProductsFailure(error: tFailure.message),
      ],
    );
  });
}