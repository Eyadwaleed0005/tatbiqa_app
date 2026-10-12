import 'package:get_it/get_it.dart';
import 'package:tatbiqa/feature/sessions/data/data_source/session_product_hive_local_data_source.dart';
import 'package:tatbiqa/feature/sessions/data/data_source/session_product_hive_local_data_source_impl.dart';
import 'package:tatbiqa/feature/sessions/data/repo_impl/session_products_repo_impl.dart';
import 'package:tatbiqa/feature/sessions/domain/repo/session_product_repo.dart';
import 'package:tatbiqa/feature/sessions/domain/usecase/session_product_usecase.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/drinks_selection_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_cubit.dart';

void registerAddSessionProductDependencies(GetIt getIt) {
  _registerLocalDataSources(getIt);
  _registerRepositories(getIt);
  _registerUseCases(getIt);
  _registerCubits(getIt);
}

void _registerLocalDataSources(GetIt getIt) {
  getIt.registerLazySingleton<SessionProductsHiveLocalDataSource>(
    () => SessionProductsHiveLocalDataSourceImpl(
      hiveService: getIt(),
    ),
  );
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<SessionProductsRepo>(
    () => SessionProductRepoImpl(
      localDataSource: getIt<SessionProductsHiveLocalDataSource>(),
    ),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<SessionProductUseCase>(
    () => SessionProductUseCase(repo: getIt<SessionProductsRepo>()),
  );
}

void _registerCubits(GetIt getIt) {
  
  getIt.registerFactory<SessionProductCubit>(
    () => SessionProductCubit(   getIt<SessionProductUseCase>(),),
  );
 getIt.registerFactory<DrinksSelectionCubit>(
    () => DrinksSelectionCubit(  ),
  );

}