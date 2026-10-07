import 'package:hive/hive.dart';
import 'package:tatbiqa/core/hive/hive_boxes.dart';
import 'package:tatbiqa/feature/reports/data/datasource/dashboard_hive_local_data_source.dart';
import 'package:tatbiqa/feature/reports/domain/entity/dashboard_entity.dart';
import 'package:tatbiqa/feature/rooms/data/models/room_model.dart';
import 'package:tatbiqa/feature/sessions/data/model/session_model.dart';



class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  @override
  Future<DashboardEntity> getDashboardReport({
    required bool isDaily,
    required DateTime targetDate,
  }) async {
    final sessionsBox = Hive.box<SessionModel>(HiveBoxes.sessions);
    final roomsBox = Hive.box<RoomModel>(HiveBoxes.rooms);

    final roomsMap = {for (var r in roomsBox.values) r.id: r.name};

    final filteredSessions = sessionsBox.values.where((session) {
      if (session.status != 'closed' || session.endTime == null) return false;
      final end = session.endTime!;
      if (isDaily) {
        return end.year == targetDate.year &&
            end.month == targetDate.month &&
            end.day == targetDate.day;
      } else {
        return end.year == targetDate.year && end.month == targetDate.month;
      }
    }).toList();

    double totalIncome = 0;
    double playstationIncome = 0;
    double productsIncome = 0;
    int totalPlayMinutes = 0;

    final Map<int, Map<String, dynamic>> roomStats = {};

    for (var session in filteredSessions) {
      totalIncome += session.totalCost;
      playstationIncome += session.playstationCost;
      productsIncome += session.productsCost;
      totalPlayMinutes += session.durationMinutes ?? 0;

      final roomId = session.roomId;
      roomStats.putIfAbsent(roomId, () => {
            'name': roomsMap[roomId] ?? session.roomName,
            'sessionsCount': 0,
            'totalMinutes': 0,
            'playIncome': 0.0,
            'productsIncome': 0.0,
            'totalIncome': 0.0,
          });

      roomStats[roomId]!['sessionsCount'] =
          (roomStats[roomId]!['sessionsCount'] as int) + 1;
      roomStats[roomId]!['totalMinutes'] =
          (roomStats[roomId]!['totalMinutes'] as int) + (session.durationMinutes ?? 0);
      roomStats[roomId]!['playIncome'] =
          (roomStats[roomId]!['playIncome'] as double) + session.playstationCost;
      roomStats[roomId]!['productsIncome'] =
          (roomStats[roomId]!['productsIncome'] as double) + session.productsCost;
      roomStats[roomId]!['totalIncome'] =
          (roomStats[roomId]!['totalIncome'] as double) + session.totalCost;
    }

    String? topRevRoom;
    String? leastRevRoom;
    String? topTimeRoom;
    String? leastTimeRoom;
    List<RoomPerformanceEntity> roomsPerformanceList = [];

    if (roomStats.isNotEmpty) {
      var sortedByRev = roomStats.entries.toList()
        ..sort((a, b) => (b.value['totalIncome'] as double).compareTo(a.value['totalIncome'] as double));

      var sortedByTime = roomStats.entries.toList()
        ..sort((a, b) => (b.value['totalMinutes'] as int).compareTo(a.value['totalMinutes'] as int));

      topRevRoom = "${sortedByRev.first.value['name']} — ${sortedByRev.first.value['totalIncome'].toStringAsFixed(0)} ج.م";
      leastRevRoom = "${sortedByRev.last.value['name']} — ${sortedByRev.last.value['totalIncome'].toStringAsFixed(0)} ج.م";

      topTimeRoom = "${sortedByTime.first.value['name']} — ${sortedByTime.first.value['totalMinutes']} دقيقة";
      leastTimeRoom = "${sortedByTime.last.value['name']} — ${sortedByTime.last.value['totalMinutes']} دقيقة";

      for (var entry in roomStats.entries) {
        roomsPerformanceList.add(
          RoomPerformanceEntity(
            roomName: entry.value['name'],
            sessionsCount: entry.value['sessionsCount'],
            totalMinutes: entry.value['totalMinutes'],
            playIncome: entry.value['playIncome'],
            productsIncome: entry.value['productsIncome'],
            totalIncome: entry.value['totalIncome'],
          ),
        );
      }
    }

    return DashboardEntity(
      totalIncome: totalIncome,
      playstationIncome: playstationIncome,
      productsIncome: productsIncome,
      totalSessionsCount: filteredSessions.length,
      totalPlayMinutes: totalPlayMinutes,
      topRoomByRevenue: topRevRoom,
      leastRoomByRevenue: leastRevRoom,
      topRoomByTime: topTimeRoom,
      leastRoomByTime: leastTimeRoom,
      roomsPerformance: roomsPerformanceList,
    );
  }
}