import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/data_entry/cubit/data_entry_cubit.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  final TextEditingController noController = TextEditingController();
  MobileScannerController scannerController = MobileScannerController();
  int totalMember = 0;

  bool hasScanned = false;
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DataEntryCubit>(context).totalGetEntry(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(title: 'Gate Entry', actions: []),
      body: RefreshIndicator(
        backgroundColor: AppColor.whiteColor,
        color: AppColor.themePrimaryColor,
        elevation: 0,
        onRefresh: () {
          return BlocProvider.of<DataEntryCubit>(
            context,
          ).totalGetEntry(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 62.h,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final scanWindow = Rect.fromCenter(
                      center: Offset(
                        constraints.maxWidth / 2,
                        constraints.maxHeight / 2,
                      ),
                      width: 250,
                      height: 250,
                    );
                    return Stack(
                      children: [
                        MobileScanner(
                          controller: scannerController,
                          scanWindow: scanWindow,
                          onDetect: (capture) async {
                            if (!isScanning) return;
                            setState(() {
                              isScanning = false;
                            });
                            // 3. Stop the camera immediately so it stops looking for codes
                            await scannerController.stop();

                            final barcode = capture.barcodes.first;
                            log('Scanned: ${barcode.rawValue}');

                            // 4. Run your Cubit logic
                            await BlocProvider.of<DataEntryCubit>(
                              context,
                            ).getEntry(
                              context,
                              sNumber: barcode.rawValue.toString(),
                              scannerController: scannerController,
                            );

                            // 5. IMPORTANT: Add a slight delay before restarting
                            // to give the user time to move the phone away.
                            await Future.delayed(
                              const Duration(milliseconds: 1500),
                            );

                            setState(() {
                              isScanning = true;
                            });

                            // 6. Restart the camera hardware
                          },
                        ),
                        if (isScanning) ...[
                          ClipRect(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.srcOut,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      backgroundBlendMode: BlendMode.dstOut,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 250,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.themePrimaryColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColor.themePrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<DataEntryCubit>(
                            context,
                          ).getExtraEntry(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(
                            child: CustomText(
                              text: 'Add 1 Extra Member',
                              color: AppColor.themePrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(20),

                    BlocBuilder<DataEntryCubit, DataEntryState>(
                      builder: (context, state) {
                        if (state is DataEntryLoaded) {
                          totalMember = state.totalMember;
                        }
                        return Container(
                          width: 100.w,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: AppColor.themePrimaryColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                CustomText(
                                  text: 'Total Member',
                                  fontSize: 18,
                                  color: AppColor.blackColor,
                                ),
                                Gap(10),
                                CustomText(
                                  text: totalMember.toString(),
                                  fontSize: 32,
                                  color: AppColor.themePrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Gap(10.h),
            ],
          ),
        ),
      ),
    );
  }
}
