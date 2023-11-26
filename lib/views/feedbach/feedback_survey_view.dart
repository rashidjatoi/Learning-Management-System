import 'package:agriconnect/services/database_services.dart';
import 'package:agriconnect/utils/utils.dart';
import 'package:agriconnect/widgets/custom_btn.dart';
import 'package:agriconnect/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';

class FeedbackSurveyView extends StatefulWidget {
  const FeedbackSurveyView({Key? key}) : super(key: key);

  @override
  State<FeedbackSurveyView> createState() => _FeedbackSurveyViewState();
}

class _FeedbackSurveyViewState extends State<FeedbackSurveyView> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController academicController;
  late TextEditingController supportController;
  late TextEditingController learningController;

  double rating = 0;

  @override
  void initState() {
    super.initState();
    academicController = TextEditingController();
    supportController = TextEditingController();
    learningController = TextEditingController();
  }

  @override
  void dispose() {
    academicController.dispose();
    supportController.dispose();
    learningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.8,
        title: const Text("Feedback Survey"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/agricultureuni.png',
              height: 200,
            ),
          ),
          const SizedBox(height: 15),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  textEditingController: academicController,
                  hintText: "Academic Experience",
                  labelText: "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Academic Experience';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  textEditingController: supportController,
                  hintText: "Support Services",
                  labelText: "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Support Services';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  textEditingController: learningController,
                  hintText: "Learning Environment",
                  labelText: "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Learning Environment';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('Rank based on your expirence in department'),
                ),
                // Add Rating/Slider widget for ranking
                Slider(
                  value: rating,
                  onChanged: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                  min: 0,
                  max: 9,
                  divisions: 9,
                  label: rating.round().toString(),
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
                DatabaseServices.saveUserFeedback(
                  academic: academicController.text,
                  support: supportController.text,
                  learning: learningController.text,
                  rating: rating.toString(),
                ).then((value) => Utils.showToast(
                    message: "Feedback Saved",
                    bgColor: Colors.grey,
                    textColor: Colors.black));
              }
            },
          )
        ],
      ),
    );
  }
}
