import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/reports/data/datasource/reports_hive_local_data_source.dart';
import 'package:tatbiqa/feature/reports/domain/entity/reports_entity.dart';
import 'package:tatbiqa/feature/reports/domain/repo/reports_repo.dart';

class ReportsRepoImpl implements ReportsRepo {
  final ReportsLocalDataSource localDataSource;

  ReportsRepoImpl({required this.localDataSource});

  @override
  Future<Either<Failure, ReportsEntity>> getDailyReport(DateTime date) async {
    try {
      final report = await localDataSource.getReports(
        isDaily: true,
        targetDate: date,
      );
      return right(report);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReportsEntity>> getMonthlyReport(
    int year,
    int month,
  ) async {
    try {
      final report = await localDataSource.getReports(
        isDaily: false,
        targetDate: DateTime(year, month),
      );
      return right(report);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
}
