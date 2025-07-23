import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_filed_box.dart';
import 'package:svt_ppm/utils/widgets/custom_radio_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

class ExamFormScreen extends StatefulWidget {
  const ExamFormScreen({super.key});

  @override
  State<ExamFormScreen> createState() => _ExamFormScreenState();
}

class _ExamFormScreenState extends State<ExamFormScreen> {
  String selectedGender = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Exam (GK) Form', notificationOnTap: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Gap(24),
              CustomTextField(
                hintText: 'Enter Member Name',
                labelText: 'Member Name*',
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Select Serial Number',
                labelText: 'Series*',
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Enter Student Name',
                labelText: 'Student Name*',
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Enter Mobile Number',
                labelText: 'Student Father Name*',
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Enter Email',
                labelText: 'Student Sarnem*',
              ),
              Gap(20),
              CustomFieldBox(
                title: 'Gender',
                children: [
                  customRadio(
                    buttonImage:
                        selectedGender == 'Male'
                            ? AppImage.radioButton
                            : AppImage.circle,
                    title: 'Male',
                    genderIcon: '',
                    borderColor: AppColor.transparentColor,
                    padding: EdgeInsets.zero,
                    onTap: () {
                      log('shuiasudya');
                      setState(() {
                        selectedGender = 'Male';
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  customRadio(
                    buttonImage:
                        selectedGender == 'Female'
                            ? AppImage.radioButton
                            : AppImage.circle,
                    title: 'Female',
                    genderIcon: '',
                    borderColor: AppColor.transparentColor,
                    padding: EdgeInsets.zero,
                    onTap: () {
                      setState(() {
                        selectedGender = 'Female';
                      });
                    },
                  ),
                ],
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Enter Mobile Number',
                labelText: 'Mobile Number*',
              ),
              Gap(20),
              CustomTextField(hintText: 'Enter Email', labelText: 'Email ID*'),
              Gap(20),
              CustomTextField(
                hintText: 'Select Standard',
                labelText: 'Standard*',
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Select Language',
                labelText: 'Language*',
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Enter School / College Email',
                labelText: 'School / College Name*',
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Village Name*',
                labelText: 'Enter Village Name*',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomButton(text: 'Submit', onTap: () {}),
      ),
    );
  }
}
