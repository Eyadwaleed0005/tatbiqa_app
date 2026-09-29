import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/cafe/domain/entity/cafe_entity.dart';

abstract class CafeRepo {
  Future<Either<Failure, CafeEntity>> saveCafeInfo({
    required String cafeName,
    required String email,
    required String ownerName,
    required String phone,
  });
}