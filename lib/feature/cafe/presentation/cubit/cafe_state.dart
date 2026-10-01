import 'package:equatable/equatable.dart';
import 'package:tatbiqa/feature/cafe/domain/entity/cafe_entity.dart';

sealed class CafeState extends Equatable {
  const CafeState();

  @override
  List<Object?> get props => [];
}

class CafeInitial extends CafeState {}

class SaveCafeLoading extends CafeState {}

class SaveCafeSuccess extends CafeState {
  final CafeEntity cafeEntity;
  const SaveCafeSuccess({required this.cafeEntity});

  @override
  List<Object?> get props => [cafeEntity];
}

class CafeError extends CafeState {
  final String message;
  const CafeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetDataCafeLoading extends CafeState {}

class GetDataCafeSuccess extends CafeState {
  final CafeEntity cafeEntity;
  const GetDataCafeSuccess({required this.cafeEntity});

  @override
  List<Object?> get props => [cafeEntity];
}

class GetDataCafeError extends CafeState {
  final String message;
  const GetDataCafeError({required this.message});

  @override
  List<Object?> get props => [message];
}
