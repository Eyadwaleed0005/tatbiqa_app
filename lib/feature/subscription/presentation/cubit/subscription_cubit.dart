import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/cafe/data/models/cafe_model.dart';
import 'package:tatbiqa/feature/subscription/domain/usecase/subscription_usecase.dart';
import 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final CheckSubscriptionUseCase checkSubscriptionUseCase;

  SubscriptionCubit(this.checkSubscriptionUseCase)
      : super(SubscriptionInitial());

  Future<void> checkStatus(CafeModel cafe) async {
    emit(SubscriptionLoading());
    try {
      final isExpired = await checkSubscriptionUseCase.checkTrial(cafe.phone);

      if (isExpired) {
        DateTime? endDate;
        try {
          endDate = await checkSubscriptionUseCase.getTrialEndDate(cafe.phone);
        } catch (_) {}

        emit(SubscriptionExpiredState(
          cafeName: cafe.cafeName,
          endDate: endDate,
        ));
      } else {
        emit(SubscriptionActiveState());
      }
    } catch (e) {
      emit(SubscriptionErrorState(e.toString()));
    }
  }
}