import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class RenetSheet extends StatelessWidget {
  final GoogleMapController mapController;
  RenetSheet._(this.mapController);

  // final Uint8List byteImage;

  static Future<void> show(
      BuildContext context, GoogleMapController mapsController) async {
    // final gMapController =  await mapsController;

    // final byteImage = await gMapController.takeSnapshot();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return RenetSheet._(mapsController);
      },
    );
  }

  Widget _buildLocationTile(Widget icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: icon,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }

  Widget _buildInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black.withOpacity(0.7),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHight = MediaQuery.of(context).size.height;
    return Container(
      height: 2.5 * (deviceHight / 3),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            height: 6,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          _buildLocationTile(
              Icon(
                FontAwesomeIcons.mapPin,
                color: Colors.redAccent.withOpacity(0.8),
              ),
              'Parker Rd. Allentown'),
          Align(
            alignment: Alignment(-0.85, 1.0),
            child: Container(
              width: 2.0,
              height: 16.0,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          _buildLocationTile(
              Icon(
                FontAwesomeIcons.mapPin,
                color: Colors.black.withOpacity(0.5),
              ),
              'Thornridge Cir. Shiloh'),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfo(FontAwesomeIcons.map, '8 km'),
                _buildInfo(FontAwesomeIcons.clock, '24 min'),
                _buildInfo(FontAwesomeIcons.dollarSign, '3.83'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(8, 8),
                      blurRadius: 8.0),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.translate(
                  offset: Offset(-80.0, 0.0),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: SizedBox(
                      width: 200,
                      child: Image.asset(
                        'assets/images/car.png',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 110,
                  width: 120,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: Offset(12, 12),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Standart',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '2 min - 4 pax',
                        style: TextStyle(color: Colors.black.withOpacity(0.4)),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        '\$3.89',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFF8A5C),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'See where\nyou traveled',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  FutureBuilder<Uint8List?>(
                    future: mapController.takeSnapshot(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final Uint8List byteImage = snapshot.data!;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            byteImage,
                            width: 100,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black.withOpacity(0.05)),
                        );
                      }
                    },
                  )
                ],
              )),
          SizedBox(
            height: 24.0,
          ),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.black.withOpacity(0.9),
                  size: 18,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF191A23),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Rent Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
