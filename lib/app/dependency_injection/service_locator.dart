
import 'package:get_it/get_it.dart';
import 'package:tatbiqa/app/dependency_injection/core_dependencies.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  registerCoreDependencies(getIt);

}