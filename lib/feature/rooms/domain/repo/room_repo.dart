import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';

abstract class RoomRepo {
  Future<Either<Failure, RoomEntity>> addRoom({
    required String name,
    required double hourlyRate,
  });

  Future<Either<Failure, List<RoomEntity>>> getRooms();

  Future<Either<Failure, void>> updateRoom({
    required int id,
    required String roomName,
    required double hourlyRate,
    required DateTime createdAt,
  });
  Future<Either<Failure, void>> deleteRoom({required int id});
}
