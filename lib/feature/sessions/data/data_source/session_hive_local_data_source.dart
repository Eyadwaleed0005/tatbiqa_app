import 'package:tatbiqa/feature/sessions/data/model/session_model.dart';

abstract class SessionHiveLocalDataSource {
  Future<SessionModel> startSession({
    required int roomId,
    required String roomName,
    required double hourlyRate,
  });

  Future<List<SessionModel>> getSessions();

  Future<SessionModel> endSession({
    required int sessionId,
    required double playstationCost,
    required double productsCost,
    required double totalCost,
    required int durationMinutes,
  });
}
