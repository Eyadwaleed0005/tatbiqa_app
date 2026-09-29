import 'dart:math';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/core/hive/local_database_service.dart';
import 'package:tatbiqa/feature/cafe/data/data_source/cafe_hive_local_data_source.dart';
import 'package:tatbiqa/feature/cafe/data/models/cafe_model.dart';

class CafeHiveLocalDataSourceImpl implements CafeHiveLocalDataSource {
  final LocalDatabaseService hiveService;

  CafeHiveLocalDataSourceImpl({required this.hiveService});

  @override
  Future<CafeModel> saveCafe({
    required String cafeName,
    required String email,
    required String ownerName,
    required String phone,
  }) async {
    final int cafeId = Random().nextInt(1000000);
    final cafeData = CafeModel(
      id: cafeId,
      cafeName: cafeName,
      email: email,
      ownerName: ownerName,
      phone: phone,
    );
    await hiveService.putData<CafeModel>(
      boxName: HiveBoxes.cafe,
      key: cafeId,
      value: cafeData,
    );
    return cafeData;
  }

 
}
