import 'package:flutter/material.dart';

class CarCards extends StatelessWidget {
  final VoidCallback onTapCard;
  final Animation<double> fade;

  CarCards({required this.onTapCard, required this.fade});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: FadeTransition(
          opacity: fade,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 16.0,
                ),
                ...List.generate(
                  5,
                  (index) => GestureDetector(
                    onTap: onTapCard,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 32.0),
                      padding: const EdgeInsets.all(16.0),
                      width: 160,
                      height: 220.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(4, 2),
                                blurRadius: 16.0),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          SizedBox(
                            child: Image.asset('assets/images/car.png'),
                          ),
                          Expanded(
                            child: Container(
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
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.4)),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
              ],
            ),
          ),
        ));
  }
}
