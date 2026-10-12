import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/sessions/data/data_source/session_product_hive_local_data_source.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/repo/session_product_repo.dart';

class SessionProductRepoImpl implements SessionProductsRepo {
  final SessionProductsHiveLocalDataSource localDataSource;

  SessionProductRepoImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addProductsToSession(List<SessionProductEntity> items)async {
    try {
      final sessions = await localDataSource.addProducts(items);
      return right(sessions);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SessionProductEntity>>> getSessionProducts(int sessionId) async{
    try {
      final product = await localDataSource.getBySession(sessionId);
      return right(product);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }

  }
}