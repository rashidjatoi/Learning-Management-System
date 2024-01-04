import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../widgets/custom_admin_btn.dart';

class CourseMaterialView extends StatefulWidget {
  const CourseMaterialView({super.key});

  @override
  State<CourseMaterialView> createState() => _CourseMaterialViewState();
}

class _CourseMaterialViewState extends State<CourseMaterialView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizeBox
          const SizedBox(height: 5),

          Row(
            children: [
              AdminViewButton(
                ontap: () {},
                icon: IconlyLight.document,
                iconText: "1st Semester",
              ),
              AdminViewButton(
                ontap: () {},
                icon: IconlyLight.document,
                iconText: "2nd Semester",
              ),
            ],
          ),

          // SizeBox
          const SizedBox(height: 5),

          Row(
            children: [
              AdminViewButton(
                ontap: () {},
                icon: IconlyLight.document,
                iconText: "3rd Semester",
              ),
              AdminViewButton(
                ontap: () {},
                icon: IconlyLight.document,
                iconText: "4th Semester",
              ),
            ],
          ),

          // SizeBox
          const SizedBox(height: 5),

          Row(
            children: [
              AdminViewButton(
                ontap: () {},
                icon: IconlyLight.document,
                iconText: "5th Semester",
              ),
              AdminViewButton(
                ontap: () {},
                icon: IconlyLight.document,
                iconText: "6th Semester",
              ),
            ],
          ),

          // SizeBox
          const SizedBox(height: 5),

          Row(
            children: [
              AdminViewButton(
                ontap: () {},
                icon: IconlyLight.document,
                iconText: "7th Semester",
              ),
              AdminViewButton(
                ontap: () {},
                icon: IconlyLight.document,
                iconText: "8th Semester",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
