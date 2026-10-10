import 'package:get_it/get_it.dart';
import 'package:tatbiqa/feature/reports/data/datasource/reports_hive_local_data_source.dart';
import 'package:tatbiqa/feature/reports/data/datasource/reports_hive_local_datasource_impl.dart';
import 'package:tatbiqa/feature/reports/data/repo_impl/reports_repo_impl.dart';
import 'package:tatbiqa/feature/reports/domain/repo/reports_repo.dart';
import 'package:tatbiqa/feature/reports/domain/usecase/reports_usecase.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/reports_cubit.dart';

void registerDashboardDependencies(GetIt getIt) {
  _registerLocalDataSources(getIt);
  _registerRepositories(getIt);
  _registerCubits(getIt);
  _registerUseCases(getIt);
}

void _registerLocalDataSources(GetIt getIt) {
  getIt.registerLazySingleton<ReportsLocalDataSource>(
    () => DashboardLocalDataSourceImpl(),
  );
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<ReportsRepo>(
    () => ReportsRepoImpl(localDataSource: getIt<ReportsLocalDataSource>()),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<ReportsUseCase>(
    () => ReportsUseCase(repo: getIt<ReportsRepo>()),
  );
}

void _registerCubits(GetIt getIt) {
  getIt.registerFactory<ReportsCubit>(
    () => ReportsCubit(getIt<ReportsUseCase>()),
  );
}
