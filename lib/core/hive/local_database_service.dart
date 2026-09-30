import 'package:hive/hive.dart';

abstract class LocalDatabaseService {
  Future<T?> getById<T>({required String boxName, required dynamic key});

  Future<List<T>> getAll<T>({required String boxName});

  Future<void> putData<T>({
    required String boxName,
    required dynamic key,
    required T value,
  });

  Future<void> addData<T>({required String boxName, required T value});

  Future<void> deleteData<T>({required String boxName, required dynamic key});

  Stream<BoxEvent> watchBox({required String boxName});
}
