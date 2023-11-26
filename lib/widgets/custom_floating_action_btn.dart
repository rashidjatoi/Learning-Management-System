import 'package:agriconnect/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String btnText;
  final VoidCallback ontap;
  const CustomFloatingActionButton({
    super.key,
    required this.btnText,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(customThemeColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        onPressed: ontap,
        child: Text(
          btnText,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "DMSans Medium",
          ),
        ),
      ),
    );
  }
}
