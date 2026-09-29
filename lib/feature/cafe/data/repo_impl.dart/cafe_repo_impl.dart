import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/cafe/data/data_source/cafe_hive_local_data_source.dart';
import 'package:tatbiqa/feature/cafe/domain/entity/cafe_entity.dart';
import 'package:tatbiqa/feature/cafe/domain/repo/cafe_repo.dart';

class CafeRepoImpl extends CafeRepo {
  final CafeHiveLocalDataSource localDataSource;

  CafeRepoImpl({required this.localDataSource});
  @override
  Future<Either<Failure, CafeEntity>> saveCafeInfo({
    required String cafeName,
    required String email,
    required String ownerName,
    required String phone,
  }) async {
    try {
      final data = await localDataSource.saveCafe(
        cafeName: cafeName,
        email: email,
        ownerName: ownerName,
        phone: phone,
      );
      return right(data);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
}
