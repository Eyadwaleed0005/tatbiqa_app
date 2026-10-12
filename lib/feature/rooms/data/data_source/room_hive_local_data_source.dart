import 'package:tatbiqa/feature/rooms/data/models/room_model.dart';

abstract class RoomHiveLocalDataSource {
  Future<RoomModel> addRoom({required String name, required double hourlyRate});

  Future<List<RoomModel>> getRooms();
  Future< void> deleteRoom({required int id});

  Future< void> updateRoom({
    required int id,
 required String name,
    required double hourlyRate,
    required DateTime createdAt    
  });
}
