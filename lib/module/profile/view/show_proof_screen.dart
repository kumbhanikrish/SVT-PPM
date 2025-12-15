import 'package:flutter/material.dart';

import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';

import 'package:webview_flutter/webview_flutter.dart';

class ShowProofScreen extends StatefulWidget {
  final dynamic argument;
  const ShowProofScreen({super.key, this.argument});

  @override
  State<ShowProofScreen> createState() => _ShowProofScreenState();
}

class _ShowProofScreenState extends State<ShowProofScreen> {
  WebViewController controller = WebViewController( );

  @override
  void initState() {
    String memberFamilyCard = widget.argument['memberFamilyCard'] ?? '';
    super.initState();
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..loadHtmlString(memberFamilyCard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Proof Details', actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
