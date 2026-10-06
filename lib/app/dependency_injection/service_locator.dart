import 'package:get_it/get_it.dart';
import 'package:tatbiqa/app/dependency_injection/core_dependencies.dart';
import 'package:tatbiqa/app/dependency_injection/features/add_session_product_dependencies.dart';
import 'package:tatbiqa/app/dependency_injection/features/cafe_setup_dependencies.dart';
import 'package:tatbiqa/app/dependency_injection/features/products_dependencies.dart';
import 'package:tatbiqa/app/dependency_injection/features/rooms_dependencies.dart';
import 'package:tatbiqa/app/dependency_injection/features/sessions_setup_dependencies.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  registerCoreDependencies(getIt);
  registerCafeDependencies(getIt);
  registerRoomsDependencies(getIt);
  registerProductsDependencies(getIt);
  registerSessionsDependencies(getIt);
  registerAddSessionProductDependencies(getIt);
}
