import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  List<LoginModel> noOfMemberList = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(
      context,
    ).memberFamily(context, pageName: 'profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Member',
        notificationOnTap: () {},

        actions: const [],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetHomeState) {
            if (state.noOfMemberList.isEmpty) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPage.homeScreen,
                (route) => false,
              );
            }
          }
        },
        builder: (context, state) {
          if (state is GetHomeState) {
            noOfMemberList = state.noOfMemberList;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),

            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: noOfMemberList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColor.themePrimaryColor,
                          border: Border.all(
                            color: AppColor.dividerColor,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColor.whiteColor,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: CustomCachedImage(
                                imageUrl: noOfMemberList[index].photo,
                                height: 45,
                                width: 45,
                              ),
                            ),
                          ),
                          title: CustomText(
                            text: noOfMemberList[index].name,
                            color: AppColor.whiteColor,
                          ),
                          subtitle: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.badge_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const Gap(10),

                                Flexible(
                                  child: CustomText(
                                    text:
                                        "ID: ${noOfMemberList[index].memberId} ${'(${noOfMemberList[index].relation})'}",
                                    color: AppColor.whiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    overflow: true,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context).verifyOtp(
                                context,
                                number: noOfMemberList[index].mobileNo,
                                otp: '1234',
                                switchUser: true,
                                memberId: noOfMemberList[index].memberId,
                              );
                            },
                            child: CustomText(
                              text: 'Login',
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Gap(16);
                    },
                  ),
                ),
                CustomTextButton(
                  text: 'Back to home',
                  color: AppColor.hintColor,
                  fontSize: 14,
                  
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppPage.homeScreen,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
