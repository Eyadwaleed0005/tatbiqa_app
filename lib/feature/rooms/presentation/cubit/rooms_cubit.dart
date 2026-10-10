
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/rooms/domain/usecase/room_use_case.dart';
import 'package:tatbiqa/feature/rooms/presentation/cubit/rooms_state.dart';
import 'package:tatbiqa/feature/sessions/data/model/session_model.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final RoomUseCase roomUseCase;

  RoomsCubit({required this.roomUseCase}) : super(RoomsInitial());

  Future<void> getRooms() async {
    if (state is! RoomsLoaded) emit(RoomsLoading());

    final result = await roomUseCase.getRooms();

    result.fold(
      (failure) => emit(RoomsError(failure.message)),
      (rooms) {
        if (rooms.isEmpty) {
          emit(RoomsEmpty());
        } else {
          final sortedRooms = rooms.reversed.toList();

          final sessionsBox = Hive.box<SessionModel>(HiveBoxes.sessions);
          final productsBox =
              Hive.box<SessionProductEntity>(HiveBoxes.sessionProducts);

          final Map<int, double> productsCostBySession = {};
          for (final p in productsBox.values) {
            productsCostBySession[p.sessionId] =
                (productsCostBySession[p.sessionId] ?? 0.0) + p.totalPrice;
          }

          final Map<int, SessionEntity> activeSessionsMap = {};
          final Map<int, Map<String, dynamic>> roomsStatsMap = {
            for (final room in sortedRooms)
              room.id: {'revenue': 0.0, 'count': 0},
          };

          final now = DateTime.now();

          for (final session in sessionsBox.values) {
            final stats = roomsStatsMap[session.roomId];
            if (stats == null) continue;

            if (session.status == 'active') {
              final productsCost = productsCostBySession[session.id] ?? 0.0;

              activeSessionsMap[session.roomId] = SessionModel(
                id: session.id,
                roomId: session.roomId,
                roomName: session.roomName,
                hourlyRate: session.hourlyRate,
                startTime: session.startTime,
                endTime: session.endTime,
                durationMinutes: session.durationMinutes,
                playstationCost: session.playstationCost,
                productsCost: productsCost, 
                totalCost: session.totalCost,
                status: session.status,
                createdAt: session.createdAt,
              );
            } else if (session.status == 'closed' && session.endTime != null) {
              final end = session.endTime!;
              if (end.year == now.year &&
                  end.month == now.month &&
                  end.day == now.day) {
                stats['count'] = (stats['count'] as int) + 1;
                stats['revenue'] =
                    (stats['revenue'] as double) + session.totalCost;
              }
            }
          }

          emit(RoomsLoaded(sortedRooms, activeSessionsMap, roomsStatsMap));
        }
      },
    );
  }
}