import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/location_controller.dart';

class LocationView extends GetView<LocationController> {
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Location')),
      body: Obx(() {
        final pos = controller.currentPosition.value;
        final center = pos != null ? LatLng(pos.latitude, pos.longitude) : LatLng(-7.98, 112.63); // fallback
        return Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: center,
                initialZoom: 16.0,
                maxZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a','b','c'],
                ),
                if (pos != null) MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(pos.latitude, pos.longitude),
                      width: 80,
                      height: 80,
                      child: Container(
                        child: Icon(Icons.my_location, size: 36),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'centerBtn',
                    child: Icon(Icons.my_location),
                    mini: true,
                    onPressed: () {
                      if (pos != null) {
                        mapController.move(LatLng(pos.latitude, pos.longitude), 17);
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  Obx(() => FloatingActionButton.extended(
                    heroTag: 'trackBtn',
                    label: Text(controller.isTracking.value ? 'Stop' : 'Start'),
                    icon: Icon(controller.isTracking.value ? Icons.stop : Icons.play_arrow),
                    onPressed: () {
                      controller.isTracking.value ? controller.stopTracking() : controller.startTracking();
                    },
                  )),
                  SizedBox(height: 8),
                  Obx(() => ElevatedButton(
                    onPressed: controller.toggleMode,
                    child: Text(controller.mode.value == ProviderMode.gps ? 'Mode: GPS' : 'Mode: Network'),
                  )),
                ],
              ),
            ),
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.white70,
                child: Obx(() {
                  if (pos == null) return Text('No position');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lat: ${pos.latitude.toStringAsFixed(6)}'),
                      Text('Lng: ${pos.longitude.toStringAsFixed(6)}'),
                      Text('Accuracy: ${pos.accuracy} m'),
                      Text('Speed: ${pos.speed} m/s'),
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      }),
    );
  }
}
