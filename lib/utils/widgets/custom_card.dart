import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomMainCard extends StatelessWidget {
  final String image;
  final String date;
  final double? width;
  final String title;
  final String des;
  final String joinText;
  final bool showButton;
  final void Function() onTap;
  final void Function() cardOnTap;
  const CustomMainCard({
    super.key,
    required this.image,
    required this.date,
    required this.title,
    required this.des,
    required this.joinText,
    required this.onTap,
    required this.showButton,
    required this.cardOnTap,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 236,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.5, color: AppColor.themePrimaryColor),
      ),
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: cardOnTap,
        child: Column(
          children: <Widget>[
            CustomCachedImage(
              imageUrl: image,
              height: 107,
              width: 100.w,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gap(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTitleName(
                    title: 'Date',
                    text: date,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      CustomText(text: title, fontSize: 14),
                      Gap(10),
                      CustomText(
                        text: des,
                        color: AppColor.hintColor,
                        fontSize: 12,
                      ),
                      Gap(7),
                    ],
                  ),
                ),

                if (showButton) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.themePrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),

                    child: InkWell(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: CustomText(
                            text: joinText,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String image;
  final String date;
  final double? width;
  final String title;
  final String des;
  final String time;
  final String joinText;
  final bool showButton;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? imageBorderRadius;
  final void Function()? onTap;
  final void Function()? cardOnTap;
  final double? height;

  const CustomCard({
    super.key,
    required this.image,
    required this.date,
    required this.title,
    required this.des,
    required this.time,
    required this.joinText,
    this.width,
    this.height,
    this.borderRadius,
    this.imageBorderRadius,
    this.onTap,
    this.cardOnTap,
    this.showButton = true,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        color: AppColor.fillColor,
      ),
      margin: EdgeInsets.only(right: 6),
      child: InkWell(
        onTap: cardOnTap,
        child: Column(
          children: <Widget>[
            CustomCachedImage(
              imageUrl: image,
              height: 88,
              width: 100.w,
              borderRadius:
                  imageBorderRadius ??
                  BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gap(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTitleName(
                          image: AppImage.date,
                          icon: showButton,
                          title: 'Date',
                          fontSize: 10,
                          text: date,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      if (time.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: CustomText(
                            text: time,

                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                CustomDivider(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      CustomText(
                        text: title,
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(5),
                      CustomText(
                        text: des,
                        maxLines: showButton ? 1 : 3,
                        color: AppColor.hintColor,
                        fontSize: 10,
                      ),
                      Gap(7),
                    ],
                  ),
                ),
                if (showButton == true) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.themePrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),

                    child: InkWell(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Center(
                          child: CustomText(
                            text: joinText,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppFeatureCard extends StatelessWidget {
  final String image;
  final String title;
  final void Function() onTap;
  const CustomAppFeatureCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.fillColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),

        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(image),
            CustomText(text: title, fontSize: 14, fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}

class CustomPresidentCard extends StatelessWidget {
  final String image;
  final String name;
  final String position;
  final String des;
  const CustomPresidentCard({
    super.key,
    required this.image,
    required this.name,
    required this.position,
    required this.des,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.fillColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CustomCachedImage(
              height: 112,
              width: 112,
              borderRadius: BorderRadius.circular(15),
              imageUrl: image,
            ),
            Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(text: name, fontWeight: FontWeight.w600),
                  Gap(10),
                  CustomText(
                    text: position,
                    fontWeight: FontWeight.w400,
                    color: AppColor.hintColor,
                  ),
                  Gap(10),

                  CustomText(
                    text: des,
                    fontWeight: FontWeight.w400,
                    color: AppColor.hintColor,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTeamCard extends StatelessWidget {
  final String image;
  final String name;
  final String position;
  final String number;
  const CustomTeamCard({
    super.key,
    required this.image,
    required this.number,
    required this.name,
    required this.position,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.fillColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            CustomCachedImage(
              height: 85,
              width: 85,
              borderRadius: BorderRadius.circular(15),
              imageUrl: image,
            ),
            Gap(7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomText(
                  text: name,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: false,
                ),
                Gap(7),
                CustomText(
                  text: position,
                  fontWeight: FontWeight.w400,
                  color: AppColor.hintColor,
                  fontSize: 10,
                ),
                Gap(7),
                InkWell(
                  onTap: () async {
                    final uri = Uri(scheme: 'tel', path: number);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      // Optionally show error
                      print("Could not launch dialer");
                    }
                  },
                  child: CustomText(
                    text: number,
                    fontWeight: FontWeight.w400,
                    color: AppColor.hintColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KitCard extends StatelessWidget {
  final String image;
  final String title;
  final String status;
  final String rejectReason;
  final String joinText;
  final bool showButton;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;
  void Function()? cardOnTap;

  KitCard({
    super.key,
    required this.image,
    required this.title,
    required this.status,
    required this.joinText,
    required this.rejectReason,
    this.borderRadius,
    this.onTap,
    this.cardOnTap,
    this.showButton = true,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardOnTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          color: AppColor.fillColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CustomCachedImage(
                imageUrl: image,
                height: 80,
                borderRadius: BorderRadius.circular(12),
              ),
              Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),

                    status.isNotEmpty
                        ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  status == 'Pending'
                                      ? AppColor.amberColor.withOpacity(0.1)
                                      : status == 'Rejected'
                                      ? AppColor.redColor.withOpacity(0.1)
                                      : status == 'Delivered'
                                      ? AppColor.themePrimaryColor.withOpacity(
                                        0.1,
                                      )
                                      : AppColor.greenColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            child: CustomText(
                              text: status,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color:
                                  status == 'Pending'
                                      ? AppColor.amberColor
                                      : status == 'Rejected'
                                      ? AppColor.redColor
                                      : status == 'Delivered'
                                      ? AppColor.themePrimaryColor
                                      : AppColor.greenColor,
                            ),
                          ),
                        )
                        : showButton == true
                        ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.themePrimaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),

                            child: InkWell(
                              onTap: onTap,
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Center(
                                  child: CustomText(
                                    text: joinText,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        : Container(),

                    status == 'Rejected'
                        ? Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: CustomTitleName(
                            text: rejectReason,
                            title: 'Reason',
                            color: AppColor.redColor,
                            fontWeight: FontWeight.w600,
                            textColor: AppColor.redColor.withOpacity(0.5),
                          ),
                        )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Container(
    // decoration: BoxDecoration(
    //   borderRadius: borderRadius ?? BorderRadius.circular(5),
    //   color: AppColor.fillColor,
    // ),
    //   margin: EdgeInsets.only(right: 6),
    //   child: InkWell(
    //     onTap: cardOnTap,
    //     child: Column(
    //       children: <Widget>[

    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Gap(5),

    //
    //
    //             Gap(7),
    //             if (showButton == true) ...[
    //               Gap(22),

    //             ],
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
