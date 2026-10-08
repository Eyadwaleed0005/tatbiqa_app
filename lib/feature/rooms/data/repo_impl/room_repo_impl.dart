import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/rooms/data/data_source/room_hive_local_data_source.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';
import 'package:tatbiqa/feature/rooms/domain/repo/room_repo.dart';

class RoomRepoImpl implements RoomRepo {
  final RoomHiveLocalDataSource localDataSource;

  RoomRepoImpl({required this.localDataSource});

  @override
  Future<Either<Failure, RoomEntity>> addRoom({
    required String name,
    required double hourlyRate,
  }) async {
    try {
      final roomModel = await localDataSource.addRoom(
        name: name,
        hourlyRate: hourlyRate,
      );

      return right(roomModel);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RoomEntity>>> getRooms() async {
    try {
      final rooms = await localDataSource.getRooms();
      return right(rooms);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRoom({required int id}) async {
    try {
      await localDataSource.deleteRoom(id: id);
      return right(null);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateRoom({
    required int id,
    required String roomName,
    required double hourlyRate,
    required DateTime createdAt,
  }) async {
    try {
      await localDataSource.updateRoom(
        id: id,
        name: roomName,
        hourlyRate: hourlyRate,
        createdAt: createdAt,
      );
      return right(null);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
}
