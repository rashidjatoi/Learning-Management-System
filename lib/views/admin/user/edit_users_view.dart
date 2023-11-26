import 'package:agriconnect/services/services_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../../widgets/custom_btn.dart';
import '../widgets/custom_table_widget.dart';

class EditUsersView extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditUsersView({super.key, required this.data});

  @override
  State<EditUsersView> createState() => _EditUsersViewState();
}

class _EditUsersViewState extends State<EditUsersView> {
  String role = "";
  bool btnLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Users Details"),
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
                  hint: const Text("Role"),
                  isExpanded: true,
                  underline: const ColoredBox(color: Colors.transparent),
                  items: const [
                    DropdownMenuItem(
                      value: "admin",
                      child: Text("admin"),
                    ),
                    DropdownMenuItem(
                      value: "user",
                      child: Text("user"),
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
                      "role": role,
                    },
                  ).then((value) {
                    setState(() {
                      btnLoading = false;
                    });
                    Get.back();
                    Utils.showToast(
                      message: "Role Changed",
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
                debugPrint(widget.data["uid"]);
              },
            )
          ],
        ),
      ),
    );
  }
}
