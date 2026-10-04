import 'package:tatbiqa/feature/sessions/data/model/session_model.dart';

abstract class SessionHiveLocalDataSource {
  Future<SessionModel> startSession({
    required int roomId,
    required String roomName,
    required double hourlyRate,
  });
  
  Future<List<SessionModel>> getSessions();
}