import 'package:equatable/equatable.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object?> get props => [];
}

final class SubscriptionInitial extends SubscriptionState {}

final class SubscriptionLoading extends SubscriptionState {}

final class SubscriptionActiveState extends SubscriptionState {}

class SubscriptionExpiredState extends SubscriptionState {
  final String cafeName;
  final DateTime? endDate;

  const SubscriptionExpiredState({this.cafeName = '-', this.endDate});
}
final class SubscriptionErrorState extends SubscriptionState {
  final String message;

  const SubscriptionErrorState(this.message);

  @override
  List<Object?> get props => [message];
}