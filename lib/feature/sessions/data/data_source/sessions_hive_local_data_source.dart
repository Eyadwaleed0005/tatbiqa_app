import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/core/hive/local_database_service.dart';
import 'package:tatbiqa/feature/sessions/data/model/session_model.dart';

abstract class SessionHiveLocalDataSource {
  Future<SessionModel> startSession({
    required int roomId,
    required String roomName,
    required double hourlyRate,
  });
  
  Future<List<SessionModel>> getSessions();
}

class SessionHiveLocalDataSourceImpl implements SessionHiveLocalDataSource {
  final LocalDatabaseService hiveService;

  SessionHiveLocalDataSourceImpl({required this.hiveService});

  @override
  Future<SessionModel> startSession({
    required int roomId,
    required String roomName,
    required double hourlyRate,
  }) async {
    final now = DateTime.now();
    final session = SessionModel(
      id: now.millisecondsSinceEpoch % 2147483647,
      roomId: roomId,
      roomName: roomName,
      hourlyRate: hourlyRate,
      startTime: now,
      playstationCost: 0.0,
      productsCost: 0.0,
      totalCost: 0.0,
      status: 'active',
      createdAt: now,
    );

    await hiveService.putData<SessionModel>(
      boxName: HiveBoxes.sessions,
      key: session.id,
      value: session,
    );

    return session;
  }

  @override
  Future<List<SessionModel>> getSessions() {
    return hiveService.getAll<SessionModel>(boxName: HiveBoxes.sessions);
  }
}
