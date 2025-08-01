import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_filed_box.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';

class ShowProofScreen extends StatelessWidget {
  final dynamic argument;
  const ShowProofScreen({super.key, this.argument});
  @override
  Widget build(BuildContext context) {
    String frontProof = argument['frontProof'] ?? '';
    String backProof = argument['backProof'] ?? '';

    return Scaffold(
      appBar: CustomAppBar(title: 'Proof Details', actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Column(
          children: <Widget>[
            CustomFieldBox(
              title: 'Front Proof',
              children: [
                CustomCachedImage(
                  imageUrl: frontProof,
                  width: 100.w,

                  height: 200,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            Gap(20),
            CustomFieldBox(
              title: 'Back Proof',
              children: [
                CustomCachedImage(
                  imageUrl: backProof,
                  width: 100.w,
                  height: 200,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
