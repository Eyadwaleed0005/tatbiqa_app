import 'package:hive/hive.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';

part 'session_model.g.dart';

@HiveType(typeId: 3)
class SessionModel extends SessionEntity {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final int roomId;

  @override
  @HiveField(2)
  final String roomName;

  @override
  @HiveField(3)
  final double hourlyRate;

  @override
  @HiveField(4)
  final DateTime startTime;

  @override
  @HiveField(5)
  final DateTime? endTime;

  @override
  @HiveField(6)
  final int? durationMinutes;

  @override
  @HiveField(7)
  final double playstationCost;

  @override
  @HiveField(8)
  final double productsCost;

  @override
  @HiveField(9)
  final double totalCost;

  @override
  @HiveField(10)
  final String status;

  @override
  @HiveField(11)
  final DateTime createdAt;

  const SessionModel({
    required this.id,
    required this.roomId,
    required this.roomName,
    required this.hourlyRate,
    required this.startTime,
    this.endTime,
    this.durationMinutes,
    required this.playstationCost,
    required this.productsCost,
    required this.totalCost,
    required this.status,
    required this.createdAt,
  }) : super(
          id: id,
          roomId: roomId,
          roomName: roomName,
          hourlyRate: hourlyRate,
          startTime: startTime,
          endTime: endTime,
          durationMinutes: durationMinutes,
          playstationCost: playstationCost,
          productsCost: productsCost,
          totalCost: totalCost,
          status: status,
          createdAt: createdAt,
        );
}