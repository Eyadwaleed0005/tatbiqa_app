import 'package:tatbiqa/app/tatbiqa_app.dart';
import 'package:tatbiqa/app/app_initializer.dart';
import 'package:tatbiqa/core/services/device_preview_service.dart';

Future<void> main() async {
  await AppInitializer.initialize();
  DevicePreviewService.run(child: const TatbiqaApp());
}
