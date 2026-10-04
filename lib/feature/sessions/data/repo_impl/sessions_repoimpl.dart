import 'package:dartz/dartz.dart';
import 'package:tatbiqa/core/error/failure.dart';
import 'package:tatbiqa/feature/sessions/data/data_source/session_hive_local_data_source.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/repo/session_repo.dart';

class SessionRepoImpl implements SessionRepo {
  final SessionHiveLocalDataSource localDataSource;

  SessionRepoImpl({required this.localDataSource});

  @override
  Future<Either<Failure, SessionEntity>> startSession({
    required int roomId,
    required String roomName,
    required double hourlyRate,
  }) async {
    try {
      final sessionModel = await localDataSource.startSession(
        roomId: roomId,
        roomName: roomName,
        hourlyRate: hourlyRate,
      );
      return right(sessionModel);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
@override
  Future<Either<Failure, List<SessionEntity>>> getSessions() async {
    try {
      final sessions = await localDataSource.getSessions();
      return right(sessions);
    } catch (e) {
      return left(LocalDatabaseFailure(e.toString()));
    }
  }
}