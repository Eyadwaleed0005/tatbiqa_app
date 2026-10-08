import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_product_entity.dart';
import 'package:tatbiqa/feature/sessions/domain/usecase/session_product_usecase.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_state.dart';

class SessionProductCubit extends Cubit<SessionProductState> {
  final SessionProductUseCase sessionProductUseCase;

  SessionProductCubit(this.sessionProductUseCase) : super(SessionProductInitial());

   Future<void> addProductsToSession(
    List<SessionProductEntity> items,
  ) async {
 emit(SessionProductLoading());
    final result = await sessionProductUseCase.addProductsToSession(items);

    result.fold(
      (failure) => emit(SessionProductError(failure.message)),
      (productSession) => emit(SessionProductAdded()),
    );
  }

  Future<void> getSessionProducts(
    int sessionId,
  ) async {
 emit(SessionProductLoading());
    final result = await sessionProductUseCase.getSessionProducts(sessionId);

    result.fold(
      (failure) => emit(SessionProductError(failure.message)),
      (productSession) => emit(SessionProductSuccess(productSession)),
    );


  }
}
