import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/cafe/domain/usecase/cafe_use_case.dart';
import 'package:tatbiqa/feature/cafe/presentation/cubit/cafe_state.dart';

class CafeCubit extends Cubit<CafeState> {
  final CafeUseCase cafeUseCase;

  CafeCubit({required this.cafeUseCase}) : super(CafeInitial());

  Future<void> saveCafeInfo({
    required String cafeName,
    required String email,
    required String ownerName,
    required String phone,
  }) async {
    emit(CafeLoading());

    final result = await cafeUseCase.saveCafeInfo(
      cafeName: cafeName,
      email: email,
      ownerName: ownerName,
      phone: phone,
    );

    result.fold(
      (failure) => emit(CafeError(message: failure.message)),
      (cafeEntity) => emit(CafeSuccess(cafeEntity: cafeEntity)),
    );
  }
}