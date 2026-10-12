import 'package:get_it/get_it.dart';
import 'package:tatbiqa/feature/rooms/data/data_source/room_hive_local_data_source.dart';
import 'package:tatbiqa/feature/rooms/data/data_source/room_hive_local_data_source_impl.dart';
import 'package:tatbiqa/feature/rooms/data/repo_impl/room_repo_impl.dart';
import 'package:tatbiqa/feature/rooms/domain/repo/room_repo.dart';
import 'package:tatbiqa/feature/rooms/domain/usecase/room_use_case.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/add_room_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/room_settings_cubit.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_cubit.dart';

void registerRoomsDependencies(GetIt getIt) {
  _registerLocalDataSources(getIt);
  _registerRepositories(getIt);
  _registerUseCases(getIt);
  _registerCubits(getIt);
}

void _registerLocalDataSources(GetIt getIt) {
  getIt.registerLazySingleton<RoomHiveLocalDataSource>(
    () => RoomHiveLocalDataSourceImpl(hiveService: getIt()),
  );
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<RoomRepo>(
    () => RoomRepoImpl(localDataSource: getIt<RoomHiveLocalDataSource>()),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<RoomUseCase>(
    () => RoomUseCase(repo: getIt<RoomRepo>()),
  );
}

void _registerCubits(GetIt getIt) {
  getIt.registerFactory<AddRoomCubit>(
    () => AddRoomCubit(addRoomUseCase: getIt<RoomUseCase>()),
  );

  getIt.registerFactory<RoomsCubit>(
    () => RoomsCubit(roomUseCase: getIt<RoomUseCase>()),
  );
  getIt.registerFactory<RoomSettingsCubit>(
    () => RoomSettingsCubit(roomUseCase: getIt<RoomUseCase>()),
  );
}
