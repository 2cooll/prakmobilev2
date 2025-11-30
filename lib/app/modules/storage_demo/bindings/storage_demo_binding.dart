import 'package:get/get.dart';

import 'package:mobileapp/app/modules/storage_demo/controllers/storage_demo_controller.dart';
import 'package:mobileapp/app/services/local_notes_service.dart';
import 'package:mobileapp/app/services/cloud_notes_service.dart';
import 'package:mobileapp/app/services/settings_service.dart';

class StorageDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalNotesService>(() => LocalNotesService());
    Get.lazyPut<CloudNotesService>(() => CloudNotesService());
    Get.lazyPut<SettingsService>(() => SettingsService());

    Get.lazyPut<StorageDemoController>(
      () => StorageDemoController(
        settingsService: Get.find<SettingsService>(),
        localNotesService: Get.find<LocalNotesService>(),
        cloudNotesService: Get.find<CloudNotesService>(),
      ),
    );
  }
}
