
import 'package:tatbiqa/feature/cafe/data/models/cafe_model.dart';

abstract class CafeHiveLocalDataSource {
  Future<CafeModel> saveCafe({
    required String cafeName,
    required String email,
    required String ownerName,
    required String phone,
  });
   
}
