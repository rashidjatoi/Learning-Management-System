import 'package:agriconnect/services/database_services.dart';
import 'package:agriconnect/views/job_posting/job_posting_view.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:agriconnect/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';

class AddJobView extends StatefulWidget {
  const AddJobView({super.key});

  @override
  State<AddJobView> createState() => _AddJobViewState();
}

class _AddJobViewState extends State<AddJobView> {
  late TextEditingController titleController;
  late TextEditingController aboutController;
  late TextEditingController contactController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    aboutController = TextEditingController();
    contactController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    aboutController.dispose();
    contactController.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Add Projects"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  textEditingController: titleController,
                  labelText: "Title",
                  hintText: "Job Title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter job title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  textEditingController: aboutController,
                  labelText: "About",
                  hintText: "Job About",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter job about';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  textEditingController: contactController,
                  labelText: "Details",
                  hintText: "Job Details",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter job details';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            btnRadius: 50,
            btnHeight: 40,
            btnMargin: 10,
            btnText: "Submit",
            ontap: () {
              if (formKey.currentState!.validate()) {
                DatabaseServices.saveJobs(
                  title: titleController.text,
                  about: aboutController.text,
                  contact: contactController.text,
                ).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JobPostingView()));
                });
              }
            },
          )
        ],
      ),
    );
  }
}
