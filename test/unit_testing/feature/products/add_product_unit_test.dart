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

  const tName = 'Coffee';
  const tPrice = 50.0;
   final  tProductEntity = ProductEntity(id: 1, name: tName, price: tPrice, isAvailable: true, createdAt: DateTime.now(), updatedAt:  DateTime.now());
  const tFailure = LocalDatabaseFailure('Error occurred');

  group('ProductsCubit - Add Product', () {
    test('initial state should be ProductsInitial', () {
      expect(cubit.state, equals(ProductsInitial()));
    });

    blocTest<ProductsCubit, ProductsState>(
      'emits [AddProductsLoading, AddProductsSuccess] when addProdcts is successful',
      build: () {
        when(
          () => mockProductsUseCase.addProducts(name: tName, price: tPrice),
        ).thenAnswer((_) async =>  Right(tProductEntity));
        return cubit;
      },
      act: (cubit) => cubit.addProdcts(name: tName, price: tPrice),
      expect: () => [
        AddProductsLoading(),
         AddProductsSuccess(products: tProductEntity),
      ],
    );

    blocTest<ProductsCubit, ProductsState>(
      'emits [AddProductsLoading, AddProductsFailure] when addProdcts fails',
      build: () {
        when(
          () => mockProductsUseCase.addProducts(name: tName, price: tPrice),
        ).thenAnswer((_) async => const Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.addProdcts(name: tName, price: tPrice),
      expect: () => [
        AddProductsLoading(),
         AddProductsFailure(error: tFailure.message),
      ],
    );
  });
}