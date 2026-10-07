import 'package:tatbiqa/feature/reports/domain/entity/dashboard_entity.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardEntity> getDashboardReport({
    required bool isDaily,
    required DateTime targetDate,
  });
}