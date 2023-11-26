import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String tileText;
  const CustomListTile({
    super.key,
    this.icon = IconlyBold.profile,
    this.tileText = "Rashid Ali",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: customThemeColor,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          tileText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : customThemeColor,
          ),
        )
      ],
    );
  }
}
