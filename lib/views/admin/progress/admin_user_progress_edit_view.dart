import 'package:agriconnect/services/services_constants.dart';
import 'package:agriconnect/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../../widgets/custom_btn.dart';
import '../widgets/custom_table_widget.dart';

class AdminUserProgressEditView extends StatefulWidget {
  final Map<String, dynamic> data;
  const AdminUserProgressEditView({super.key, required this.data});

  @override
  State<AdminUserProgressEditView> createState() =>
      _AdminUserProgressEditViewState();
}

class _AdminUserProgressEditViewState extends State<AdminUserProgressEditView> {
  String role = "";
  bool btnLoading = false;

  late TextEditingController resultController;

  @override
  void initState() {
    super.initState();
    resultController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    resultController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Student Progress"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
              ),
              children: [
                customTableWidget(
                  headingText: "First Name",
                  dataText: widget.data["firstName"],
                ),
                customTableWidget(
                  headingText: "Last Name",
                  dataText: widget.data["lastName"],
                ),
                customTableWidget(
                  headingText: "Email",
                  dataText: widget.data["email"],
                ),
                customTableWidget(
                  headingText: "Department",
                  dataText: widget.data["department"],
                ),
                customTableWidget(
                  headingText: "Semester",
                  dataText: widget.data["semester"],
                ),
                TableRow(
                  children: [
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Role"),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data["role"]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: DropdownButton(
                  value: role.isNotEmpty ? role : null,
                  hint: const Text("Semester"),
                  isExpanded: true,
                  underline: const ColoredBox(color: Colors.transparent),
                  items: const [
                    DropdownMenuItem(
                      value: "1st",
                      child: Text("1st"),
                    ),
                    DropdownMenuItem(
                      value: "2nd",
                      child: Text("2nd"),
                    ),
                    DropdownMenuItem(
                      value: "3rd",
                      child: Text("3rd"),
                    ),
                    DropdownMenuItem(
                      value: "4th",
                      child: Text("4th"),
                    ),
                    DropdownMenuItem(
                      value: "5th",
                      child: Text("5th"),
                    ),
                    DropdownMenuItem(
                      value: "6th",
                      child: Text("6th"),
                    ),
                    DropdownMenuItem(
                      value: "7th",
                      child: Text("7th"),
                    ),
                    DropdownMenuItem(
                      value: "8th",
                      child: Text("8th"),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      role = value.toString();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              textEditingController: resultController,
              hintText: "Enter Result",
              labelText: "",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Result';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            CustomButton(
              btnText: "Update",
              loading: btnLoading,
              ontap: () {
                try {
                  setState(() {
                    btnLoading = true;
                  });
                  firebaseDatabase.child(widget.data["uid"]).update(
                    {
                      "semester": role,
                      "result": resultController.text.toString(),
                    },
                  ).then((value) {
                    setState(() {
                      btnLoading = false;
                    });
                    Get.back();
                    Utils.showToast(
                      message: "Result Uploaded",
                      bgColor: Colors.green,
                      textColor: Colors.white,
                    );
                  });
                } catch (e) {
                  debugPrint(e.toString());
                  setState(() {
                    btnLoading = false;
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
