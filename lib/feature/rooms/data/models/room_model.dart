import 'package:hive/hive.dart';
import 'package:tatbiqa/feature/rooms/domain/entity/room_entity.dart';

part 'room_model.g.dart';

@HiveType(typeId: 1)
class RoomModel extends RoomEntity {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final String name;

  @override
  @HiveField(2)
  final double hourlyRate;

  @override
  @HiveField(3)
  final DateTime createdAt;

  @override
  @HiveField(4)
  final DateTime updatedAt;

  const RoomModel({
    required this.id,
    required this.name,
    required this.hourlyRate,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          id: id,
          name: name,
          hourlyRate: hourlyRate,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
}