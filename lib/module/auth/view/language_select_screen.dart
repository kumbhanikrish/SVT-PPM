import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
// Assuming CustomAppBar is in the correct path, otherwise remove or adjust the import
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

// We must convert StatelessWidget to StatefulWidget to manage the selected language state
class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  String _selectedLanguage = 'English';

  final List<String> _languages = ['Gujarati', 'Hindi', 'English'];

  Future<void> _showSelectedLanguage(
    BuildContext context, {
    required String language,
  }) async {
    await localDataSaver.setLanguage(
      language == 'Gujarati'
          ? 'gu'
          : language == 'Hindi'
          ? 'hi'
          : 'en',
    );
    Navigator.pushNamed(
      context,
      AppPage.selectionScreen,

      arguments: {'addMember': false, 'language': language},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Language Select', actions: const []),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListView.separated(
              itemCount: _languages.length,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Gap(16);
              },
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  activeColor: AppColor.themePrimaryColor,
                  title: CustomText(text: _languages[index]),
                  value: _languages[index],
                  groupValue: _selectedLanguage,
                  onChanged: (value) {
                    log('value :$value');
                    setState(() {
                      _selectedLanguage = value ?? 'English';
                    });
                  },
                );
              },
            ),
            Gap(24),
            CustomButton(
              text: 'Confirm Selection',
              onTap: () {
                _showSelectedLanguage(context, language: _selectedLanguage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
