import 'package:get_it/get_it.dart';
import 'package:tatbiqa/feature/products/data/data_source/products_hive_local_data_source.dart';
import 'package:tatbiqa/feature/products/data/data_source/products_hive_local_data_source_impl.dart';
import 'package:tatbiqa/feature/products/data/repo_impl/products_repo_impl.dart';
import 'package:tatbiqa/feature/products/domain/repo/products_repo.dart';
import 'package:tatbiqa/feature/products/domain/usecase/products_usecase.dart';
import 'package:tatbiqa/feature/products/presentation/cubit/products_cubit.dart';

void registerProductsDependencies(GetIt getIt) {
  _registerLocalDataSources(getIt);
  _registerRepositories(getIt);
  _registerUseCases(getIt);
  _registerCubits(getIt);
}

void _registerLocalDataSources(GetIt getIt) {
  getIt.registerLazySingleton<ProductsHiveLocalDataSource>(
    () => ProductsHiveLocalDataSourceImpl(
   localDatabaseService   : getIt(),
    ),
  );
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<ProductsRepo>(
    () => ProductsRepoImpl(
      localDataSource: getIt<ProductsHiveLocalDataSource>(),
    ),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<ProductsUseCase>(
    () => ProductsUseCase(repo: getIt<ProductsRepo>()),
  );
}

void _registerCubits(GetIt getIt) {
  
  getIt.registerFactory<ProductsCubit>(
    () => ProductsCubit(products:    getIt<ProductsUseCase>(),),
  );
}