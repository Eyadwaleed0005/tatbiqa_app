import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/reports/domain/entity/dashboard_entity.dart';

abstract class DashboardRepo {
  Future<Either<Failure, DashboardEntity>> getDailyReport(DateTime date);
  Future<Either<Failure, DashboardEntity>> getMonthlyReport(int year, int month);
}