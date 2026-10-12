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
  final tProductEntity = ProductEntity(
    id: tId,
    name: 'Coffee',
    price: 50.0,
    isAvailable: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  const tFailure = LocalDatabaseFailure('Error occurred');

  group('ProductsCubit - Delete Product', () {
    test('initial state should be ProductsInitial', () {
      expect(cubit.state, equals(ProductsInitial()));
    });

    blocTest<ProductsCubit, ProductsState>(
      'emits [DeleteProductsLoading, DeleteProductsSuccess] when deleteProduct is successful',
      build: () {
        when(
          () => mockProductsUseCase.deleteProduct(id: tId),
        ).thenAnswer((_) async =>  Right(tProductEntity));
        return cubit;
      },
      act: (cubit) => cubit.deleteProduct(id: tId),
      expect: () => [
        DeleteProductsLoading(),
         DeleteProductsSuccess(message: 'تم حذف المنتج بنجاح '),
      ],
    );

    blocTest<ProductsCubit, ProductsState>(
      'emits [DeleteProductsLoading, DeleteProductsFailure] when deleteProduct fails',
      build: () {
        when(
          () => mockProductsUseCase.deleteProduct(id: tId),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.deleteProduct(id: tId),
      expect: () => [
        DeleteProductsLoading(),
         DeleteProductsFailure(error: tFailure.message),
      ],
    );
  });
}