import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/rooms/domain/repo/room_repo.dart';

class RoomUseCase {
  final RoomRepo repo;

  RoomUseCase({required this.repo});

  Future<Either<Failure, RoomEntity>> addRoom({
    required String name,
    required double hourlyRate,
  }) {
    return repo.addRoom(name: name, hourlyRate: hourlyRate);
  }

  Future<Either<Failure, List<RoomEntity>>> getRooms() {
    return repo.getRooms();
  }

  Future<Either<Failure, void>> updateRoom({
    required int id,
    required String roomName,
    required double hourlyRate,
    required DateTime createdAt,
  }) {
    return repo.updateRoom(
      id: id,
      roomName: roomName,
      hourlyRate: hourlyRate,
      createdAt: createdAt,
    );

  }

  Future<Either<Failure, void>> deleteRoom({required int id}){
    return repo.deleteRoom(id: id);
  }


}


