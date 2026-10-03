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
  
}