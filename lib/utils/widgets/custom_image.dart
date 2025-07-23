import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';

class CustomTextFiledImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final Color? color;
  const CustomTextFiledImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.color,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height ?? 20,
        width: width ?? 20,
        child: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            image,
            color: color ?? AppColor.themePrimaryColor,
            height: height ?? 20,
            width: width ?? 20,
          ),
        ),
      ),
    );
  }
}

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.fill,
        placeholder:
            (context, url) => Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: AppColor.themePrimaryColor,
                ),
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(AppImage.imageError, fit: BoxFit.cover),
              ),
            ),
      ),
    );
  }
}
