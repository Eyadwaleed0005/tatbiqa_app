import 'package:get_it/get_it.dart';
import 'package:tatbiqa/feature/sessions/data/data_source/session_hive_local_data_source.dart';
import 'package:tatbiqa/feature/sessions/data/data_source/sessions_hive_local_data_source.dart';
import 'package:tatbiqa/feature/sessions/data/repo_impl/sessions_repoimpl.dart';
import 'package:tatbiqa/feature/sessions/domain/repo/session_repo.dart';
import 'package:tatbiqa/feature/sessions/domain/usecase/session_use_case.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_cubit.dart';

void registerSessionsDependencies(GetIt getIt) {
  _registerLocalDataSources(getIt);
  _registerRepositories(getIt);
  _registerUseCases(getIt);
  _registerCubits(getIt);
}

void _registerLocalDataSources(GetIt getIt) {
  getIt.registerLazySingleton<SessionHiveLocalDataSource>(
    () => SessionHiveLocalDataSourceImpl(hiveService: getIt()),
  );
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<SessionRepo>(
    () => SessionRepoImpl(localDataSource: getIt<SessionHiveLocalDataSource>()),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<SessionUseCase>(
    () => SessionUseCase(repo: getIt<SessionRepo>()),
  );
}

void _registerCubits(GetIt getIt) {
  getIt.registerFactory<SessionsCubit>(
    () => SessionsCubit( getIt<SessionUseCase>()),
  );
}