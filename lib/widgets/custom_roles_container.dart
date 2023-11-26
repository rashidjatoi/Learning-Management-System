import 'package:flutter/material.dart';

class CustomRolesContainer extends StatelessWidget {
  final String btnTitle;
  final IconData icon;
  const CustomRolesContainer(
      {super.key, required this.btnTitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        width: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 10),
            Text(btnTitle),
          ],
        ),
      ),
    );
  }
}
