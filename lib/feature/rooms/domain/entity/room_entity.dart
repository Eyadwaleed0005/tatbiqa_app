class RoomEntity {
  final int id;
  final String name;
  final double hourlyRate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RoomEntity({
    required this.id,
    required this.name,
    required this.hourlyRate,
    required this.createdAt,
    required this.updatedAt,
  });
}