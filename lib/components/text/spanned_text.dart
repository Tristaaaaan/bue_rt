import 'package:flutter/material.dart';

class SpannedText extends StatelessWidget {
  final String value;
  final String unit;
  final String label;
  final IconData icon;
  const SpannedText({
    super.key,
    required this.value,
    required this.unit,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              label,
              style: const TextStyle(
                fontSize: 18,
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
                  fontSize: 70,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
              ),
              TextSpan(
                text: unit,
                style: TextStyle(
                  fontFamily: 'Digi',
                  fontSize: 24, // Change this to the desired size for "km"
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
