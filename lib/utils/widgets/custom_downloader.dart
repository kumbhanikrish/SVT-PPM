import 'package:pdf/pdf.dart';

import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:html/parser.dart' as html_parser;

String htmlToPlainText(String html) {
  final document = html_parser.parse(html);
  return document.body?.text ?? '';
}

Future<void> generateAndDownloadPdf({
  required String title,
  required String content,
}) async {
  final pdf = pw.Document();

  final plainText = htmlToPlainText(content); // ✅ Convert HTML to text

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              title,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 16),
            pw.Text(plainText, style: pw.TextStyle(fontSize: 14)),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
