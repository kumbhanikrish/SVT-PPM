import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:svt_ppm/module/data_entry/cubit/data_entry_cubit.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _hasScanned = false; // Flag to ensure only one scan is processed

  @override
  Widget build(BuildContext context) {
    DataEntryCubit dataEntryCubit = BlocProvider.of<DataEntryCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: MobileScanner(
        onDetect: (capture) async {
          if (_hasScanned) return; // Prevent further scans after the first one

          final barcode = capture.barcodes.first;
          _hasScanned = true; // Mark as scanned

          await dataEntryCubit.getEntry(
            context,
            sNumber: barcode.rawValue.toString(),
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}
