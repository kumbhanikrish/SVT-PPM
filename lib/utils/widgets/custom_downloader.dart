import 'package:pdf/pdf.dart';

import 'package:printing/printing.dart';

Future<void> generateAndDownloadPdf({
  required String title,
  required String content,
}) async {
  Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async {
      return await Printing.convertHtml(format: format, html: content);
    },
    name: '$title.pdf',
  );
}
