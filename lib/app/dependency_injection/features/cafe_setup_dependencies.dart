import 'package:get_it/get_it.dart';
import 'package:tatbiqa/feature/cafe/data/data_source/cafe_hive_local_data_source.dart';
import 'package:tatbiqa/feature/cafe/data/data_source/cafe_hive_local_data_source_impl.dart';
import 'package:tatbiqa/feature/cafe/data/repo_impl.dart/cafe_repo_impl.dart';
import 'package:tatbiqa/feature/cafe/domain/repo/cafe_repo.dart';
import 'package:tatbiqa/feature/cafe/domain/usecase/cafe_use_case.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_cubit.dart';

void registerCafeDependencies(GetIt getIt) {
  _registerLocalDataSources(getIt);
  _registerRepositories(getIt);
  _registerUseCases(getIt);
  _registerCubits(getIt);
}

void _registerLocalDataSources(GetIt getIt) {
  getIt.registerLazySingleton<CafeHiveLocalDataSource>(
    () => CafeHiveLocalDataSourceImpl(
      hiveService: getIt(),
    ),
  );
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<CafeRepo>(
    () => CafeRepoImpl(
      localDataSource: getIt<CafeHiveLocalDataSource>(),
    ),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<CafeUseCase>(
    () => CafeUseCase(repo: getIt<CafeRepo>()),
  );
}

void _registerCubits(GetIt getIt) {
  
  getIt.registerFactory<CafeCubit>(
    () => CafeCubit(  cafeUseCase: getIt<CafeUseCase>(),),
  );
}