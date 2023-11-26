import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({super.key});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        value: selectedDepartment,
        decoration: const InputDecoration(
          labelText: 'Department',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            selectedDepartment = value;
          });
        },
        items: const [
          DropdownMenuItem(
            value: 'Software Engineering',
            child: Text('Software Engineering'),
          ),
          DropdownMenuItem(
            value: 'Computer Science',
            child: Text('Computer Science'),
          ),
          DropdownMenuItem(
            value: 'Physics',
            child: Text('Physics'),
          ),
          DropdownMenuItem(
            value: 'Botany',
            child: Text('Botany'),
          ),
        ],
      ),
    );
  }
}
