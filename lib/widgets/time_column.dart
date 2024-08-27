import 'package:flutter/material.dart';
import 'package:recording/utils/colors.dart';

class TimeColumn extends StatelessWidget {
  const TimeColumn({super.key, required this.label, required this.time});
  final String label;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0), // Adjust as needed
          child: Text(
            "$label ",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.red),
          ),
        ),
        Positioned(
          top: 20,
          left: 42,
          child: Text(
            time,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.red,
            ),
          ),
        ),
      ],
    );
  }
}
