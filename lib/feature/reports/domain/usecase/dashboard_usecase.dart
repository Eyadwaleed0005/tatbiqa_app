import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/reports/domain/entity/dashboard_entity.dart';
import 'package:tatbiqa/feature/reports/domain/repo/dashboard_repo.dart';
class DashboardUseCase {
  final DashboardRepo repo;

  DashboardUseCase({required this.repo});

  Future<Either<Failure, DashboardEntity>> getDailyReport(DateTime date) {
    return repo.getDailyReport(date);
  }

  Future<Either<Failure, DashboardEntity>> getMonthlyReport(int year, int month) {
    return repo.getMonthlyReport(year, month);
  }
}