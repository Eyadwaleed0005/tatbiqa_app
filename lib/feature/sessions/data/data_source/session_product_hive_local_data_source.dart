
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';

abstract class SessionProductsHiveLocalDataSource {
  Future<void> addProducts(List<SessionProductEntity> items);
  Future<List<SessionProductEntity>> getBySession(int sessionId);
}
