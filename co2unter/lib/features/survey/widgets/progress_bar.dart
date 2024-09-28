import 'package:flutter/material.dart';

class PercentageIndicator extends StatelessWidget {
  final double percentage;

  const PercentageIndicator({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: percentage,
        backgroundColor: Colors.grey[300],
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        minHeight: 8,
      ),
    );
  }
}
