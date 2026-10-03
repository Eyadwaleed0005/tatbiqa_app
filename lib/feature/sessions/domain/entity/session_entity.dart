class SessionEntity {
  final int id;
  final int roomId;
  final String roomName;
  final double hourlyRate;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final double playstationCost;
  final double productsCost;
  final double totalCost;
  final String status; 
  final DateTime createdAt;

  const SessionEntity({
    required this.id,
    required this.roomId,
    required this.roomName,
    required this.hourlyRate,
    required this.startTime,
    this.endTime,
    this.durationMinutes,
    required this.playstationCost,
    required this.productsCost,
    required this.totalCost,
    required this.status,
    required this.createdAt,
  });
}