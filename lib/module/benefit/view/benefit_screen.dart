import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/module/benefit/cubit/benefit_cubit.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class BenefitScreen extends StatefulWidget {
  const BenefitScreen({super.key});

  @override
  State<BenefitScreen> createState() => _BenefitScreenState();
}

class _BenefitScreenState extends State<BenefitScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BenefitCubit>().getBenefitData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Benefit', actions: []),
      body: BlocBuilder<BenefitCubit, BenefitState>(
        builder: (context, state) {
          // if (state is BenefitLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(
          //       color: AppColor.themePrimaryColor,
          //     ),
          //   );
          // }

          if (state is GetBenefitState) {
            final benefitData = state.benefitData;

            if (benefitData.isEmpty) {
              return const Center(child: CustomEmpty());
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: benefitData.length,
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) {
                final entry = benefitData.entries.elementAt(index);
                final String key = entry.key;
                final dynamic value = entry.value;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: key
                            .split('_')
                            .map(
                              (e) =>
                                  e.substring(0, 1).toUpperCase() +
                                  e.substring(1),
                            )
                            .join(' '),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColor.themePrimaryColor,
                      ),
                      CustomText(
                        text: value.toString(),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
