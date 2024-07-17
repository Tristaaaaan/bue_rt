import 'package:flutter/material.dart';

class SpannedText extends StatelessWidget {
  final String value;
  final String unit;
  final String? label;
  final IconData? icon;
  final bool? withLabel;
  final Color textColor;
  final double? labelSize;
  final double? valueSize;
  final double? unitSize;

  const SpannedText({
    super.key,
    required this.value,
    required this.unit,
    this.label,
    this.icon,
    this.withLabel = true,
    required this.textColor,
    this.labelSize = 18,
    this.valueSize = 50,
    this.unitSize = 26,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (withLabel!)
          Row(
            children: [
              Icon(
                icon,
                size: 18,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                label!,
                style: TextStyle(
                  fontSize: labelSize,
                ),
              )
            ],
          ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: value == "0" ? "00" : value.toString(),
                style: TextStyle(
                  fontFamily: 'Digi',
                  fontSize: valueSize,
                  fontStyle: FontStyle.italic,
                  color: textColor,
                ),
              ),
              TextSpan(
                text: unit,
                style: TextStyle(
                  fontFamily: 'Digi',
                  fontSize:
                      unitSize, // Change this to the desired size for "km"
                  fontStyle: FontStyle.italic,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
