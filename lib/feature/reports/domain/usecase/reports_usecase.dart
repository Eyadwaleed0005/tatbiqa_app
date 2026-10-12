import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/reports/domain/entity/reports_entity.dart';
import 'package:tatbiqa/feature/reports/domain/repo/reports_repo.dart';

class ReportsUseCase {
  final ReportsRepo repo;

  ReportsUseCase({required this.repo});

  Future<Either<Failure, ReportsEntity>> getDailyReport(DateTime date) {
    return repo.getDailyReport(date);
  }

  Future<Either<Failure, ReportsEntity>> getMonthlyReport(int year, int month) {
    return repo.getMonthlyReport(year, month);
  }
}
