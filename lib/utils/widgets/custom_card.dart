import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
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
  final bool applied;
  final void Function() onTap;
  final void Function() cardOnTap;
  final void Function()? onNotJoinTap;
  final void Function()? onCancelTap;

  const CustomMainCard({
    super.key,
    required this.image,
    required this.date,
    required this.applied,
    required this.title,
    required this.des,
    required this.joinText,
    required this.onTap,
    required this.showButton,
    required this.cardOnTap,
    this.onNotJoinTap,
    this.onCancelTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = AppColor.themePrimaryColor;
    final Color lightYellow = const Color(0xFFFFF9C4);

    return InkWell(
      onTap: cardOnTap,
      child: Container(
        width: width ?? 398,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: CustomCachedImage(
                    imageUrl: image,
                    width: 1000,
                    height: 200,
                  ),
                ),
              ),

              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month, size: 16, color: primaryBlue),
                    const Gap(6),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    Text(
                      "12:00 PM",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        des.isNotEmpty ? des : "No location added",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ),

              if (showButton)
                SizedBox(
                  height: 45,
                  child:
                      applied
                          ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  color: lightYellow,
                                  child: Text(
                                    "Joined",
                                    style: const TextStyle(
                                      color: AppColor.themePrimaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: InkWell(
                              //     onTap: onCancelTap ?? () {},
                              //     child: Container(
                              //       alignment: Alignment.center,
                              //       color: lightYellow,
                              //       child: Text(
                              //         "Cancel",
                              //         style: TextStyle(
                              //           color: primaryBlue,
                              //           fontWeight: FontWeight.w600,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                          : InkWell(
                            onTap: onTap,
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              color: primaryBlue,
                              child: Text(
                                joinText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                ),
            ],
          ),
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
  final String status;
  final bool showButton;
  final bool applied;
  final bool showTag;
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
    this.status = '',
    this.applied = false,
    this.showTag = false,
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
            Stack(
              children: [
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
                if (showTag) ...[
                  Positioned(
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            status == 'Passed'
                                ? AppColor.greenColor
                                : status == 'Failed'
                                ? AppColor.redColor
                                : null,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: CustomText(
                        text: status,
                        color: AppColor.whiteColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
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
                if (showButton) ...[
                  Container(
                    decoration: BoxDecoration(
                      color:
                          applied && status.isEmpty
                              ? AppColor.greenColor
                              : AppColor.themePrimaryColor,
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
  final String number;
  const CustomPresidentCard({
    super.key,
    required this.image,
    required this.name,
    required this.position,
    this.number = '',
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
          crossAxisAlignment: CrossAxisAlignment.start,

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
                  if (number.isNotEmpty) ...[
                    Gap(10),

                    CustomText(
                      text: number,
                      fontWeight: FontWeight.w400,
                      color: AppColor.hintColor,
                      fontSize: 14,
                    ),
                  ],
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

                if (number.isNotEmpty) ...[
                  Gap(7),
                  InkWell(
                    onTap: () async {
                      final uri = Uri(scheme: 'tel', path: number);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        // Optionally show error
                        log("Could not launch dialer");
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
  final void Function()? cardOnTap;

  const KitCard({
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
    Color statusBgColor;
    Color statusTextColor;

    if (status == 'Pending') {
      statusBgColor = AppColor.amberColor.withOpacity(0.1);
      statusTextColor = AppColor.amberColor;
    } else if (status == 'Rejected') {
      statusBgColor = AppColor.redColor.withOpacity(0.1);
      statusTextColor = AppColor.redColor;
    } else if (status == 'Delivered') {
      statusBgColor = AppColor.themePrimaryColor.withOpacity(0.1);
      statusTextColor = AppColor.themePrimaryColor;
    } else {
      statusBgColor = AppColor.greenColor.withOpacity(0.1);
      statusTextColor = AppColor.greenColor;
    }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCachedImage(
                imageUrl: image,
                height: 80,
                width: 80,
                borderRadius: BorderRadius.circular(12),
              ),
              const Gap(12),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.themePrimaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      if (status.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomStatusButton(
                                  color: statusBgColor,
                                  status: status,
                                  textColor: statusTextColor,
                                ),
                                if (status == 'Rejected') ...[
                                  const Gap(10),
                                  InkWell(
                                    onTap: onTap,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.themePrimaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 5,
                                      ),
                                      child: CustomText(
                                        text: 'Re-Apply',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            if (status == 'Rejected' && rejectReason.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: CustomTitleName(
                                  text: rejectReason,
                                  title: 'Reason',
                                  color: AppColor.redColor,
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColor.redColor.withOpacity(0.5),
                                ),
                              ),
                          ],
                        )
                      else if (showButton)
                        InkWell(
                          onTap: onTap,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                              color: AppColor.themePrimaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: CustomText(
                              text: joinText,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchemaItemCard extends StatelessWidget {
  final String title;
  final String? image;
  final String status;
  final bool isApplied;
  final String rejectReason;
  final VoidCallback cardOnTap;
  final VoidCallback onTap;

  const SchemaItemCard({
    super.key,
    required this.title,
    required this.image,
    required this.status,
    required this.isApplied,
    required this.rejectReason,
    required this.onTap,
    required this.cardOnTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusBgColor;
    Color statusTextColor;
    String currentStatus = status.isEmpty ? "Pending" : status;

    String statusKey = currentStatus.toLowerCase();

    if (statusKey == 'rejected') {
      statusBgColor = AppColor.redColor.withOpacity(0.1);
      statusTextColor = AppColor.redColor;
    } else if (statusKey == 'approved' || statusKey == 'delivered') {
      statusBgColor = AppColor.greenColor.withOpacity(0.1);
      statusTextColor = AppColor.greenColor;
    } else {
      statusBgColor = AppColor.amberColor.withOpacity(0.1);
      statusTextColor = AppColor.amberColor;
    }

    return InkWell(
      onTap: cardOnTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.fillColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 80,
                width: 80,
                child:
                    (image != null && image!.isNotEmpty)
                        ? Image.network(
                          image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return SvgPicture.asset(
                              AppImage.schemaDetails,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                        : SvgPicture.asset(
                          AppImage.schemaDetails,
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        color: AppColor.themePrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (!isApplied)
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColor.themePrimaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status Row
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: statusBgColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  currentStatus,
                                  style: TextStyle(
                                    color: statusTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              if (statusKey == 'rejected') ...[
                                const Gap(10),
                                InkWell(
                                  onTap: onTap,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.themePrimaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      'Re-Apply',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (statusKey == 'rejected' &&
                              rejectReason.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: CustomTitleName(
                                text: rejectReason,
                                title: 'Reason',
                                color: AppColor.redColor,
                                fontWeight: FontWeight.w600,

                                textColor: AppColor.redColor.withOpacity(0.5),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
