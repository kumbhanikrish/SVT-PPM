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
  WebViewController controller = WebViewController();

  @override
  void initState() {
    String memberFamilyCard = widget.argument['memberFamilyCard'] ?? '';
    super.initState();

    String htmlContent = """
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <style>
        body {
            margin: 0;
            padding: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            width: 100vw;
            overflow: hidden;
            background-color: #f8f9fa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            box-sizing: border-box;
        }
        .card-wrapper {
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            border-radius: 0 !important;
            box-shadow: none;
        }
        table {
            width: 100% !important;
            height: 100% !important;
            border-collapse: collapse;
            background: transparent !important;
            box-shadow: none;
        }
    </style>
</head>
<body>
    <div class="card-wrapper">
        $memberFamilyCard
    </div>
</body>
</html>
""";

    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0xFFF8F9FA))
          ..loadHtmlString(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(title: 'Proof Details', actions: []),
      body: WebViewWidget(controller: controller),
    );
  }
}
