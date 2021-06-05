import 'dart:async';
import 'dart:io';

import 'car_cards.dart';
import 'maps_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../rent_sheet/rent_sheet.dart';

const String androidMarker = 'assets/images/marker_android.png';
const String iOSMarker = 'assets/images/marker.png';

class MapBody extends StatefulWidget {
  final AnimationController animationController;

  const MapBody({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  Completer<GoogleMapController> _mapsController = Completer();

  Future<BitmapDescriptor> getMarkerIcon() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      Platform.isAndroid ? androidMarker : iOSMarker,
    );
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        child: Stack(
          children: [
         
            FutureBuilder<BitmapDescriptor>(
              future: getMarkerIcon(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapsController.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(40.221475, -76.943511),
                      zoom: 18.0,
                    ),
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    markers: <Marker>[
                      Marker(
                        markerId: MarkerId('myCard'),
                        position: LatLng(40.221958, -76.943928),
                        icon: snapshot.data!,
                        rotation: 50.0,
                        anchor: Offset(0.5, 0.5),
                      ),
                      Marker(
                        markerId: MarkerId('myCard2'),
                        position: LatLng(40.221007, -76.943416),
                        icon: snapshot.data!,
                        rotation: 143.0,
                        anchor: Offset(0.5, 0.5),
                      ),
                    ].toSet(),
                  );
                } else
                  return Container();
              },
            ),
            MapsTopBar(
              leftOffsetAnimation:
                  Tween<Offset>(begin: Offset.zero, end: Offset(-2.0, 0))
                      .animate(widget.animationController),
              rightOffsetAnimation:
                  Tween<Offset>(begin: Offset.zero, end: Offset(2.0, 0))
                      .animate(widget.animationController),
            ),
            Positioned(
              bottom: 280,
              right: 24.0,
              child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.location_searching_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
            ),
            CarCards(
                fade: Tween<double>(begin: 1.0, end: 0.0)
                    .animate(widget.animationController),
                onTapCard: () async {
                  // if (animationController.status == AnimationStatus.completed) {
                  //   animationController.reverse();
                  // } else {
                  //   animationController.forward();
                  // }

                  widget.animationController.forward();
                  final mapController = await _mapsController.future;

                  await RenetSheet.show(context, mapController);
                  widget.animationController.reverse();
                }),
          ],
        ),
      ),
    );
  }
}
