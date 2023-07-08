import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class CadastroModelController extends ChangeNotifier {
  Future<void> createPDF(File? imageFile) async {
    if (imageFile != null) {
      final pdf = pw.Document();

      final image = pw.MemoryImage(imageFile.readAsBytesSync());

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            );
          },
        ),
      );

      final output = await getTemporaryDirectory();
      final pdfPath = "${output.path}/my_pdf.pdf";
      final file = File(pdfPath);
      await file.writeAsBytes(await pdf.save());

      // Agora você pode usar o arquivo PDF para o que desejar
      print("PDF criado em: $pdfPath");
    }
  }
}
