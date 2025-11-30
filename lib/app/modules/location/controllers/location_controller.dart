import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../../../services/location_service.dart';
import 'package:intl/intl.dart';

enum ProviderMode { gps, network }

class LocationController extends GetxController {
  final LocationService _service = LocationService();

  var currentPosition = Rxn<Position>();
  var isTracking = false.obs;
  var mode = ProviderMode.gps.obs; // default GPS
  StreamSubscription<Position>? _sub;

  // For logging / experiments
  var records = <Map<String, dynamic>>[].obs;

  Future<bool> initPermission() async {
    return await _service.requestPermission();
  }

  void startTracking() async {
    if (!await initPermission()) {
      Get.snackbar('Permission', 'Location permission denied');
      return;
    }
    isTracking.value = true;
    LocationAccuracy accuracy = mode.value == ProviderMode.gps ? LocationAccuracy.best : LocationAccuracy.low;
    _sub?.cancel();
    _sub = _service.getPositionStream(accuracy: accuracy).listen((pos) {
      currentPosition.value = pos;
      // Log record for experiments
      records.add({
        'latitude': pos.latitude,
        'longitude': pos.longitude,
        'accuracy': pos.accuracy,
        'timestamp': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
        'speed': pos.speed,
      });
    }, onError: (e) {
      Get.snackbar('Error', e.toString());
    });
  }

  void stopTracking() {
    _sub?.cancel();
    _sub = null;
    isTracking.value = false;
  }

  void toggleMode() {
    if (mode.value == ProviderMode.gps) {
      mode.value = ProviderMode.network;
    } else {
      mode.value = ProviderMode.gps;
    }
    // if tracking, restart with new accuracy
    if (isTracking.value) {
      startTracking();
    }
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }

  // helper to compute distance between last two records
  double lastDistance() {
    if (records.length < 2) return 0;
    final a = records[records.length - 2];
    final b = records.last;
    return Geolocator.distanceBetween(a['latitude'], a['longitude'], b['latitude'], b['longitude']);
  }
}
