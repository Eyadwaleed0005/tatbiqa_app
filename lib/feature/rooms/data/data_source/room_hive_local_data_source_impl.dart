import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/core/hive/local_database_service.dart';
import 'package:tatbiqa/feature/rooms/data/data_source/room_hive_local_data_source.dart';
import 'package:tatbiqa/feature/rooms/data/models/room_model.dart';

class RoomHiveLocalDataSourceImpl implements RoomHiveLocalDataSource {
  final LocalDatabaseService hiveService;

  RoomHiveLocalDataSourceImpl({required this.hiveService});

  @override
  Future<RoomModel> addRoom({
    required String name,
    required double hourlyRate,
  }) async {
    final rooms = await getRooms();
    final exists = rooms.any(
      (r) => r.name.trim().toLowerCase() == name.trim().toLowerCase(),
    );

    if (exists) {
      throw Exception('اسم الغرفة موجود بالفعل');
    }

    final now = DateTime.now();
    final room = RoomModel(
      id: now.millisecondsSinceEpoch % 2147483647,
      name: name,
      hourlyRate: hourlyRate,
      createdAt: now,
      updatedAt: now,
    );

    await hiveService.putData<RoomModel>(
      boxName: HiveBoxes.rooms,
      key: room.id,
      value: room,
    );

    return room;
  }

  @override
  Future<List<RoomModel>> getRooms() {
    return hiveService.getAll<RoomModel>(boxName: HiveBoxes.rooms);
  }

  @override
  Future<void> deleteRoom({required int id}) async {
    await hiveService.deleteData<RoomModel>(boxName: HiveBoxes.rooms, key: id);
  }

  @override
  Future<void> updateRoom({
    required int id,
    required String name,
    required double hourlyRate,
    required DateTime createdAt,
  }) async {
    final room = RoomModel(
      id: id,
      name: name,
      hourlyRate: hourlyRate,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
    await hiveService.putData<RoomModel>(
      boxName: HiveBoxes.rooms,
      key: room.id,
      value: room,
    );
  }
}
