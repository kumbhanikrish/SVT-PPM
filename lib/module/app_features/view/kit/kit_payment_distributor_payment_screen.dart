import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:svt_ppm/module/app_features/cubit/kits/kits_cubit.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';

class KitPaymentDistributorPaymentScreen extends StatefulWidget {
  final dynamic argument;
  const KitPaymentDistributorPaymentScreen({super.key, required this.argument});

  @override
  State<KitPaymentDistributorPaymentScreen> createState() =>
      _KitPaymentDistributorPaymentScreenState();
}

class _KitPaymentDistributorPaymentScreenState
    extends State<KitPaymentDistributorPaymentScreen> {
  MobileScannerController scannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.argument['title'], actions: []),
      body: MobileScanner(
        controller: scannerController,
        onDetect: (capture) async {
          // 3. Stop the camera immediately so it stops looking for codes
          await scannerController.stop();

          final barcode = capture.barcodes.first;
          log('Scanned: ${barcode.rawValue}');

          await BlocProvider.of<KitsCubit>(context).kitsRegistrationStatus(
            context,
            sNumber: barcode.rawValue.toString(),
            scannerController: scannerController,
            type:
                widget.argument['title'] == 'Kit Distributor'
                    ? 'distributor'
                    : 'payment',
          );

          await Future.delayed(const Duration(milliseconds: 1500));
        },
      ),
    );
  }
}
