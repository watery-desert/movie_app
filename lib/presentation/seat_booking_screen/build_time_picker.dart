import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildDateTimePicker extends StatelessWidget {
  Widget _buildTimeTile(String time, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: selected ? Colors.red : null,
        border: selected
            ? null
            : Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
      ),
      child: Text(time),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        children: [
          Container(
            width: 100,
            child: Text('January 18', style: TextStyle(fontSize: 18)),
          ),
          Icon(
            FontAwesomeIcons.caretDown,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTimeTile(
                    '17:30',
                    true,
                  ),
                  _buildTimeTile(
                    '17:30',
                    false,
                  ),
                  _buildTimeTile(
                    '17:30',
                    false,
                  ),
                  _buildTimeTile(
                    '17:30',
                    false,
                  ),
                  _buildTimeTile(
                    '17:30',
                    false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
