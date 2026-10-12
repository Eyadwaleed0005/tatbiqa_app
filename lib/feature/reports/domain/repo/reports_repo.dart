import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/reports/domain/entity/reports_entity.dart';

abstract class ReportsRepo {
  Future<Either<Failure, ReportsEntity>> getDailyReport(DateTime date);
  Future<Either<Failure, ReportsEntity>> getMonthlyReport(int year, int month);
}
