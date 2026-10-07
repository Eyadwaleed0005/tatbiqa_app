import 'package:get_it/get_it.dart';
import 'package:tatbiqa/feature/reports/data/datasource/dashboard_hive_local_data_source.dart';
import 'package:tatbiqa/feature/reports/data/datasource/dashboard_hive_local_datasource_impl.dart';
import 'package:tatbiqa/feature/reports/data/repo_impl/dashboard_repo_impl.dart';
import 'package:tatbiqa/feature/reports/domain/repo/dashboard_repo.dart';
import 'package:tatbiqa/feature/reports/domain/usecase/dashboard_usecase.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/dashboard_cubit.dart';

void registerDashboardDependencies(GetIt getIt) {
  _registerLocalDataSources(getIt);
  _registerRepositories(getIt);
  _registerCubits(getIt);
  _registerUseCases(getIt);
}

void _registerLocalDataSources(GetIt getIt) {
  getIt.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(),
  );
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImpl(localDataSource: getIt<DashboardLocalDataSource>()),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<DashboardUseCase>(
    () => DashboardUseCase(repo: getIt<DashboardRepo>()),
  );
}

void _registerCubits(GetIt getIt) {
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(getIt<DashboardUseCase>()),
  );
}
