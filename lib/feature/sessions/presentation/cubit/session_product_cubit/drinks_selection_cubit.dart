import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/products/domain/entity/products_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';

class DrinksSelectionState {
  final Map<int, int> quantities;
  const DrinksSelectionState(this.quantities);
}

class DrinksSelectionCubit extends Cubit<DrinksSelectionState> {
  DrinksSelectionCubit() : super(const DrinksSelectionState({}));

  void change(int productId, int delta) {
    final map = Map<int, int>.from(state.quantities);
    final qty = (map[productId] ?? 0) + delta;
    if (qty <= 0) {
      map.remove(productId);
    } else {
      map[productId] = qty;
    }
    emit(DrinksSelectionState(map));
  }

  double total(List<ProductEntity> products) {
    double sum = 0;
    for (final p in products) {
      sum += p.price * (state.quantities[p.id] ?? 0);
    }
    return sum;
  }

  List<SessionProductEntity> buildItems(
    int sessionId,
    List<ProductEntity> products,
  ) {
    final items = <SessionProductEntity>[];
    for (final p in products) {
      final qty = state.quantities[p.id] ?? 0;
      if (qty == 0) continue;
      items.add(
        SessionProductEntity(
          sessionId: sessionId,
          productId: p.id,
          productName: p.name,
          unitPrice: p.price,
          quantity: qty,
          totalPrice: p.price * qty,
          createdAt: DateTime.now(),
        ),
      );
    }

    return items;
  }

  void reset() {
    emit(const DrinksSelectionState({}));
  }
}
