import 'package:tatbiqa/feature/reports/domain/entity/reports_entity.dart';

abstract class ReportsLocalDataSource {
  Future<ReportsEntity> getReports({
    required bool isDaily,
    required DateTime targetDate,
  });
}
