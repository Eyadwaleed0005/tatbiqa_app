import 'package:hive/hive.dart';
import 'package:tatbiqa/feature/cafe/domain/entity/cafe_entity.dart';

part 'cafe_model.g.dart';

@HiveType(typeId: 0)
class CafeModel extends CafeEntity {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final String cafeName;

  @override
  @HiveField(2)
  final String email;

  @override
  @HiveField(3)
  final String ownerName;

  @override
  @HiveField(4)
  final String phone;

  const CafeModel({
    required this.id,
    required this.cafeName,
    required this.email,
    required this.ownerName,
    required this.phone,
  }) : super(
          id: id,
          cafeName: cafeName,
          email: email,
          ownerName: ownerName,
          phone: phone,
        );
}