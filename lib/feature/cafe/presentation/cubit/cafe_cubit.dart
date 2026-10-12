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
    emit(SaveCafeDataLoading());

    final result = await cafeUseCase.saveCafeInfo(
      cafeName: cafeName,
      email: email,
      ownerName: ownerName,
      phone: phone,
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
