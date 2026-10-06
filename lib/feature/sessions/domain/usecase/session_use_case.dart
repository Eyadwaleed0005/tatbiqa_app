import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/repo/session_repo.dart';

class SessionUseCase {
  final SessionRepo repo;

  SessionUseCase({required this.repo});

  Future<Either<Failure, SessionEntity>> startSession({
    required int roomId,
    required String roomName,
    required double hourlyRate,
  }) {
    return repo.startSession(
      roomId: roomId,
      roomName: roomName,
      hourlyRate: hourlyRate,
    );
  }
  Future<Either<Failure, List<SessionEntity>>> getSessions() {
    return repo.getSessions();
  }
  
  Future<Either<Failure, SessionEntity>> endSession({
     required int sessionId,
  required double playstationCost,
  required double productsCost,
  required double totalCost,
  required int durationMinutes,
  }) {
    return repo.endSession(
     sessionId: sessionId,
     playstationCost: playstationCost,
     productsCost: productsCost,
     totalCost: totalCost,
     durationMinutes: durationMinutes
    );
  }
}
