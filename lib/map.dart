import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberapp/controller/controller.dart';

class Map1 extends StatefulWidget {
  const Map1({Key? key}) : super(key: key);

  @override
  State<Map1> createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  final controller = ControllerStore();

  Set<Marker> markers = {};

  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition initPosition = const CameraPosition(
    target: LatLng(-30.061593351850355, -51.16830749839041),
    zoom: 20,
  );

  initUserPosition() async {
    await controller.getPosition();

    setState(() {
      initPosition = CameraPosition(
        target: LatLng(
          controller.currentPosition!.latitude,
          controller.currentPosition!.longitude,
        ),
        zoom: 20,
      );

      Marker markerUser = Marker(
          markerId: const MarkerId('userMarker'),
          position: LatLng(controller.currentPosition!.latitude,
              controller.currentPosition!.longitude));

      markers.add(markerUser);

      moveCamera();
    });
  }

  moveCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(initPosition));
  }

  @override
  void initState() {
    initUserPosition();
    super.initState();
  }

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Mapa')),
        body: Observer(builder: (_) {
          return GoogleMap(
            markers: markers,
            onMapCreated: _onMapCreated,
            initialCameraPosition: initPosition,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          );
        }));
  }
}
