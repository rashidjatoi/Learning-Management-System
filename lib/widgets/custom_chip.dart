import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String chipText;
  final Color color;
  final Color chipTextColor;
  const CustomChip({
    super.key,
    this.color = Colors.white,
    this.chipTextColor = customThemeColor,
    required this.chipText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff30384C)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        chipText,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : customThemeColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
