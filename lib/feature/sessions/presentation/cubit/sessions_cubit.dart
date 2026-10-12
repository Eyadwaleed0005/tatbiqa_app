import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/sessions/domain/usecase/session_use_case.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  final SessionUseCase sessionUseCase;

  SessionsCubit(this.sessionUseCase) : super(SessionsInitial());

  Future<void> startSession({
    required int roomId,
    required String roomName,
    required double hourlyRate,
  }) async {
    emit(SessionsLoading());
    final result = await sessionUseCase.startSession(
      roomId: roomId,
      roomName: roomName,
      hourlyRate: hourlyRate,
    );

    result.fold(
      (failure) => emit(SessionsError(failure.message)),
      (session) => emit(SessionStartedSuccess(session)),
    );
  }

  Future<void> getSessions() async {
    emit(SessionsLoading());
    final result = await sessionUseCase.getSessions();

    result.fold(
      (failure) => emit(SessionsError(failure.message)),
      (sessions) => emit(FetchSessionsSuccess(sessions)),
    );
  }

  Future<void> endSession({
  required int sessionId,
  required double playstationCost,
  required double productsCost,
  required double totalCost,
  required int durationMinutes,
}) async {
  emit(SessionsLoading());
  
  final result = await sessionUseCase.endSession(
    sessionId: sessionId,
    playstationCost: playstationCost,
    productsCost: productsCost,
    totalCost: totalCost,
    durationMinutes: durationMinutes,
  );

  result.fold(
    (failure) => emit(SessionsError(failure.message)),
    (session) => emit(SessionCheckoutSuccess(session)), 
  );
}
}
