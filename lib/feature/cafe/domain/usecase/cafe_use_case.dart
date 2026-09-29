import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/cafe/domain/entity/cafe_entity.dart';
import 'package:tatbiqa/feature/cafe/domain/repo/cafe_repo.dart';

class CafeUseCase {
  final CafeRepo repo;

  CafeUseCase({required this.repo});

  Future<Either<Failure, CafeEntity>> saveCafeInfo({
    required String cafeName,
    required String email,
    required String ownerName,
    required String phone,
  }) async {
    return await repo.saveCafeInfo(
      cafeName: cafeName,
      email: email,
      ownerName: ownerName,
      phone: phone,
    );
  }
}