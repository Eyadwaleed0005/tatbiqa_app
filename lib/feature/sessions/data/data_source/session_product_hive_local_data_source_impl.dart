
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/core/hive/local_database_service.dart';
import 'package:tatbiqa/feature/sessions/data/data_source/session_product_hive_local_data_source.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';

class SessionProductsHiveLocalDataSourceImpl
    implements SessionProductsHiveLocalDataSource {
  final LocalDatabaseService hiveService;
  SessionProductsHiveLocalDataSourceImpl({required this.hiveService});
  @override
  Future<void> addProducts(List<SessionProductEntity> items) async {
    final base = DateTime.now().microsecondsSinceEpoch;

    final entries = <int, SessionProductEntity>{};

    for (var i = 0; i < items.length; i++) {
      final id = (base + i) % 2147483647;
      final item = items[i];

      entries[id] = SessionProductEntity(
        id: id,
        sessionId: item.sessionId,
        productId: item.productId,
        productName: item.productName,
        unitPrice: item.unitPrice,
        quantity: item.quantity,
        totalPrice: item.totalPrice,
        createdAt: item.createdAt,
      );
    }

    await hiveService.putAll<SessionProductEntity>(
      boxName: HiveBoxes.sessionProducts,
      entries: entries,
    );
  }

  @override
  Future<List<SessionProductEntity>> getBySession(int sessionId) async {
    final sessionProducts = await hiveService.getAll<SessionProductEntity>(
      boxName: HiveBoxes.sessionProducts,
    );
    return sessionProducts.where((e) => e.sessionId == sessionId).toList();
  }
}
