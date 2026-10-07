import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/reports/data/datasource/dashboard_hive_local_data_source.dart';
import 'package:tatbiqa/feature/reports/domain/entity/dashboard_entity.dart';
import 'package:tatbiqa/feature/reports/domain/repo/dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  final DashboardLocalDataSource localDataSource;

  DashboardRepoImpl({required this.localDataSource});

  @override
  Future<Either<Failure, DashboardEntity>> getDailyReport(DateTime date) async {
    try {
      final report = await localDataSource.getDashboardReport(
        isDaily: true,
        targetDate: date,
      );
      return right(report);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DashboardEntity>> getMonthlyReport(int year, int month) async {
    try {
      final report = await localDataSource.getDashboardReport(
        isDaily: false,
        targetDate: DateTime(year, month),
      );
      return right(report);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
}