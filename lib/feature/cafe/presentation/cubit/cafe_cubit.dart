import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/core/helper/helper_functions.dart';
import 'package:tatbiqa/feature/cafe/domain/usecase/cafe_use_case.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_state.dart';
import 'package:tatbiqa/feature/subscription/domain/usecase/subscription_usecase.dart';

class CafeCubit extends Cubit<CafeState> {
  final CafeUseCase cafeUseCase;
  final CheckSubscriptionUseCase subscriptionUseCase;

  CafeCubit({required this.cafeUseCase, required this.subscriptionUseCase}) : super(CafeInitial());


  Future<void> saveCafeInfo({
    required String cafeName,
    required String email,
    required String ownerName,
    required String phone,
  }) async {
    emit(SaveCafeDataLoading());

    final normalizedPhone = HelperFunctions.normalizePhone(phone);

    try {
  await subscriptionUseCase.registerTrial(normalizedPhone);
} catch (e) {
  emit(SaveCafeDataError(message: 'خطأ: $e')); 
  return;
}
    final result = await cafeUseCase.saveCafeInfo(
      cafeName: cafeName,
      email: email,
      ownerName: ownerName,
      phone: normalizedPhone,
    );

    result.fold(
      (failure) => emit(SaveCafeDataError(message: failure.message)),
      (cafeEntity) => emit(SaveCafeDataSuccess(cafeEntity: cafeEntity)),
    );
  }



  Future<void> getCafeInfo() async {
    emit(GetDataCafeLoading());

    final result = await cafeUseCase.getCafeData();

    result.fold(
      (failure) => emit(GetDataCafeError(message: failure.message)),
      (cafeEntity) => emit(GetDataCafeSuccess(cafeEntity: cafeEntity)),
    );
  }
}

