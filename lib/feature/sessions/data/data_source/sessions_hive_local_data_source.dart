import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/core/hive/local_database_service.dart';
import 'package:tatbiqa/feature/sessions/data/data_source/session_hive_local_data_source.dart';
import 'package:tatbiqa/feature/sessions/data/model/session_model.dart';

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

  @override
  Future<SessionModel> endSession({required int sessionId, required double playstationCost, required double productsCost, required double totalCost, required int durationMinutes})async {
final session = await hiveService.getData<SessionModel>(
    boxName: HiveBoxes.sessions,
    key: sessionId,
  );
if (session == null) {
    throw Exception("السيشن غير موجودة");
  }
  final now = DateTime.now();
    final updatedSession = SessionModel(
    id: session.id,
    roomId: session.roomId,
    roomName: session.roomName,
    hourlyRate: session.hourlyRate,
    startTime: session.startTime,
    endTime: now,
    durationMinutes: durationMinutes,
    playstationCost: playstationCost,
    productsCost: productsCost,
    totalCost: totalCost,
    status: 'closed', 
    createdAt: session.createdAt,
  );

  await hiveService.putData<SessionModel>(
    boxName: HiveBoxes.sessions,
    key: sessionId,
    value: updatedSession,
  );

  return updatedSession;
  }
}
