import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';

abstract class SessionProductsRepo {
  Future<Either<Failure, void>> addProductsToSession(
      List<SessionProductEntity> items);
 Future<Either<Failure, List<SessionProductEntity>>> getSessionProducts(int sessionId);
}