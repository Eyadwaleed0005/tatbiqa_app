import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbiqa/app/dependency_injection/service_locator.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/core/widgets/custom_app_bar.dart';
import 'package:tatbiqa/feature/products/presentation/cubit/products_cubit.dart';
import 'package:tatbiqa/feature/sessions/domain/entity/session_entity.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/drinks_selection_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/cubit/session_product_cubit/session_product_cubit.dart';
import 'package:tatbiqa/feature/sessions/presentation/screens/widgets/add_drinks_to_session.dart/add_drinks_to_session_content.dart';

class AddDrinksToSessionScreen extends StatelessWidget {
  final SessionEntity session;

  const AddDrinksToSessionScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt.get<ProductsCubit>()..fetchProdcts(),
            ),
            BlocProvider(create: (context) => getIt.get<SessionProductCubit>()),

            BlocProvider(
              create: (context) => getIt.get<DrinksSelectionCubit>(),
            ),
          ],
          child: AddDrinksToSessionContent(session: session),
        ),
      ),
    );
  }
}
