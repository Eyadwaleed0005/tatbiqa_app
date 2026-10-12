import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/repo/session_product_repo.dart';

class SessionProductUseCase {
  final SessionProductsRepo repo;

  SessionProductUseCase({required this.repo});
  Future<Either<Failure, void>> addProductsToSession(
    List<SessionProductEntity> items,
  ) async {
    return repo.addProductsToSession(items);
  }

  Future<Either<Failure, List<SessionProductEntity>>> getSessionProducts(
    int sessionId,
  ) async {
    return repo.getSessionProducts(sessionId);
  }
}
