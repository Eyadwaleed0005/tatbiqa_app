class RoomPerformanceEntity {
  final String roomName;
  final int sessionsCount;
  final int totalMinutes;
  final double playIncome;
  final double productsIncome;
  final double totalIncome;

  const RoomPerformanceEntity({
    required this.roomName,
    required this.sessionsCount,
    required this.totalMinutes,
    required this.playIncome,
    required this.productsIncome,
    required this.totalIncome,
  });
}

class ReportsEntity {
  final double totalIncome;
  final double playstationIncome;
  final double productsIncome;
  final int totalSessionsCount;
  final int totalPlayMinutes;
  final String? topRoomByRevenue;
  final String? leastRoomByRevenue;
  final String? topRoomByTime;
  final String? leastRoomByTime;
  final List<RoomPerformanceEntity> roomsPerformance;

  const ReportsEntity({
    required this.totalIncome,
    required this.playstationIncome,
    required this.productsIncome,
    required this.totalSessionsCount,
    required this.totalPlayMinutes,
    this.topRoomByRevenue,
    this.leastRoomByRevenue,
    this.topRoomByTime,
    this.leastRoomByTime,
    required this.roomsPerformance,
  });
}
