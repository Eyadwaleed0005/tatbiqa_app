import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tatbiqa/core/hive/hive_database_service.dart';
import 'package:tatbiqa/core/hive/local_database_service.dart';

void registerCoreDependencies(GetIt getIt) {
  _registerCoreServices(getIt);
}

void _registerCoreServices(GetIt getIt) {
  getIt.registerLazySingleton<LocalDatabaseService>(
    () => HiveDatabaseService(),
  );
  getIt.registerLazySingleton<FirebaseAuth>(
    ()=>FirebaseAuth.instance
  );
    getIt.registerLazySingleton<FirebaseFirestore>(
    ()=>FirebaseFirestore.instance
  );
}
