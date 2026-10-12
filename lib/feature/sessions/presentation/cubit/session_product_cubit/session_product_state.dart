import 'package:equatable/equatable.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';

abstract class SessionProductState extends Equatable {
  const SessionProductState();

  @override
  List<Object?> get props => [];
}

class SessionProductInitial extends SessionProductState {}

class SessionProductLoading extends SessionProductState {}

class SessionProductSuccess extends SessionProductState {
  final List <SessionProductEntity> session;

  const SessionProductSuccess(this.session);

  @override
  List<Object?> get props => [session];
}

class SessionProductAdded extends SessionProductState {}

class SessionProductError extends SessionProductState {
  final String message;

  const SessionProductError(this.message);

  @override
  List<Object?> get props => [message];
}