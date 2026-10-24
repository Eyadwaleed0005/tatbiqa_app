import 'package:get_it/get_it.dart';
import 'package:tatbiqa/feature/subscription/data/datasource/subscription_datasource.dart';
import 'package:tatbiqa/feature/subscription/data/datasource/subscription_datasource_impl.dart';
import 'package:tatbiqa/feature/subscription/data/repo_impl/subscription_repo_impl.dart';
import 'package:tatbiqa/feature/subscription/domain/repo/subscription_repo.dart';
import 'package:tatbiqa/feature/subscription/domain/usecase/subscription_usecase.dart';
import 'package:tatbiqa/feature/subscription/presentation/cubit/subscription_cubit.dart';


void registerSubscriptionDependencies(GetIt getIt) {
  _registerSubscriptionDataSources(getIt);
  _registerSubscriptionRepositories(getIt);
  _registerSubscriptionUseCases(getIt);
  _registerSubscriptionCubits(getIt);
}

void _registerSubscriptionDataSources(GetIt getIt) {
  getIt.registerLazySingleton<SubscriptionRemoteDataSource>(
    () => SubscriptionRemoteDataSourceImpl(),
  );
}

void _registerSubscriptionRepositories(GetIt getIt) {
  getIt.registerLazySingleton<SubscriptionRepo>(
    () => SubscriptionRepositoryImpl(remoteDataSource: getIt<SubscriptionRemoteDataSource>()),
  );
}

void _registerSubscriptionUseCases(GetIt getIt) {
  getIt.registerLazySingleton<CheckSubscriptionUseCase>(
    () => CheckSubscriptionUseCase(getIt<SubscriptionRepo>()),
  );
}

void _registerSubscriptionCubits(GetIt getIt) {
  getIt.registerFactory<SubscriptionCubit>(
    () => SubscriptionCubit(getIt<CheckSubscriptionUseCase>()),
  );
}