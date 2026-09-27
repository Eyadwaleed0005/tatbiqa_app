import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tatbiqa/core/helper/app_system_ui.dart';
import 'package:tatbiqa/core/widgets/custom_app_bar.dart';
import 'package:tatbiqa/feature/products/presentation/screens/widgets/product_screen_content.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: const CustomAppbar(),

      body:AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
    
      child:ProductScreenContent ()) ,);


  }
}
