import 'package:flutter_test/flutter_test.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/drinks_selection_cubit.dart';

void main() {
  late DrinksSelectionCubit cubit;

  setUp(() {
    cubit = DrinksSelectionCubit();
  });

  tearDown(() {
    cubit.close();
  });

  final tCreatedAt = DateTime(2026);

  final tProduct1 = ProductEntity(
    id: 1,
    name: 'مياه غازية',
    price: 15.0,
    createdAt: tCreatedAt,
    isAvailable: true,
    updatedAt: tCreatedAt,
  );

  final tProduct2 = ProductEntity(
    id: 2,
    name: 'عصير طازج',
    price: 30.0,
    createdAt: tCreatedAt,
    isAvailable: true,
    updatedAt: tCreatedAt,
  );

  test('initial state should have empty quantities map', () {
    expect(cubit.state.quantities, isEmpty);
  });

  group('change quantity', () {
    test('should add product to quantities map when delta is positive', () {
      cubit.change(1, 2);

      expect(cubit.state.quantities, {1: 2});
    });

    test('should increment quantity when product already exists', () {
      cubit.change(1, 1);
      cubit.change(1, 2);

      expect(cubit.state.quantities, {1: 3});
    });

    test('should decrement quantity and remove product if quantity <= 0', () {
      cubit.change(1, 2);
      cubit.change(1, -2);

      expect(cubit.state.quantities, isEmpty);
    });
  });

  test('total should calculate correct sum based on quantities and prices', () {
    cubit.change(1, 2); 
    cubit.change(2, 1); 

    final result = cubit.total([tProduct1, tProduct2]);

    expect(result, 60.0);
  });

  test('buildItems should return correct list of SessionProductEntity', () {
    cubit.change(1, 2);

    final items = cubit.buildItems(10, [tProduct1, tProduct2]);

    expect(items.length, 1);
    expect(items.first.sessionId, 10);
    expect(items.first.productId, 1);
    expect(items.first.productName, 'مياه غازية');
    expect(items.first.unitPrice, 15.0);
    expect(items.first.quantity, 2);
    expect(items.first.totalPrice, 30.0);
  });

  test('reset should clear quantities map', () {
    cubit.change(1, 3);
    cubit.reset();

    expect(cubit.state.quantities, isEmpty);
  });
}