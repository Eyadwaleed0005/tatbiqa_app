import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/feature/reports/domain/usecase/reports_usecase.dart';
import 'package:tatbiqa/feature/reports/presentation/cubit/reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportsUseCase dashboardUseCase;

  ReportsCubit(this.dashboardUseCase) : super(ReportsInitial());

  Future<void> fetchDailyReport(DateTime date) async {
    emit(ReportsLoading());
    final result = await dashboardUseCase.getDailyReport(date);
    result.fold(
      (failure) => emit(ReportsError(failure.message)),
      (report) => emit(ReportsLoaded(report)),
    );
  }

  Future<void> fetchMonthlyReport(int year, int month) async {
    emit(ReportsLoading());
    final result = await dashboardUseCase.getMonthlyReport(year, month);
    result.fold(
      (failure) => emit(ReportsError(failure.message)),
      (report) => emit(ReportsLoaded(report)),
    );
  }
}
