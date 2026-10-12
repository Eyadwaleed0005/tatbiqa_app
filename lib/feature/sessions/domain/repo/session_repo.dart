import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';

abstract class SessionRepo {
  Future<Either<Failure, SessionEntity>> startSession({
    required int roomId,
    required String roomName,
    required double hourlyRate,
  });
Future<Either<Failure, List<SessionEntity>>> getSessions();

  Future<Either<Failure, SessionEntity>> endSession({
    required int sessionId,
  required double playstationCost,
  required double productsCost,
  required double totalCost,
  required int durationMinutes,
  });
}