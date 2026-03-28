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
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f8f9fa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }
        .card-wrapper {
            width: 100%;
            max-width: 600px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        img {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        table {
            width: 100% !important;
            max-width: 100% !important;
            height: auto !important;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
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