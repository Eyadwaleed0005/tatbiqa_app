import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/reports/domain/usecase/dashboard_usecase.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardUseCase dashboardUseCase;

  DashboardCubit(this.dashboardUseCase) : super(DashboardInitial());

  Future<void> fetchDailyReport(DateTime date) async {
    emit(DashboardLoading());
    final result = await dashboardUseCase.getDailyReport(date);
    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (report) => emit(DashboardLoaded(report)),
    );
  }

  Future<void> fetchMonthlyReport(int year, int month) async {
    emit(DashboardLoading());
    final result = await dashboardUseCase.getMonthlyReport(year, month);
    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (report) => emit(DashboardLoaded(report)),
    );
  }
}