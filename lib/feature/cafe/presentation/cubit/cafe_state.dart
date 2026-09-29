import 'package:equatable/equatable.dart';
import 'package:tatbiqa/feature/cafe/domain/entity/cafe_entity.dart';

abstract class CafeState extends Equatable {
  const CafeState();

  @override
  List<Object?> get props => [];
}

class CafeInitial extends CafeState {}

class CafeLoading extends CafeState {}

class CafeSuccess extends CafeState {
  final CafeEntity cafeEntity;

  const CafeSuccess({required this.cafeEntity});

  @override
  List<Object?> get props => [cafeEntity];
}

class CafeError extends CafeState {
  final String message;

  const CafeError({required this.message});

  @override
  List<Object?> get props => [message];
}