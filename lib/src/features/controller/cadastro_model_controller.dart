import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ModelRegistrationController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  String? imagePath;

  Future<String> createPDF(String name, String imageUrl) async {
    final pdf = pw.Document();

    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Imagem de fundo
              pw.Image(pw.MemoryImage(bytes)),

              // Texto sobreposto
              pw.Positioned(
                top: 100,
                right: 20, // Alinhamento à direita
                child: pw.Text(
                  name,
                  style: pw.TextStyle(
                    fontSize: 24, // Tamanho da fonte aumentado
                    color: PdfColors.orange, // Cor laranja
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.right, // Alinhamento à direita
                ),
              ),
            ],
          );
        },
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final outputFile = File('${outputDir.path}/meu_pdf.pdf');
    await outputFile.writeAsBytes(await pdf.save());

    notifyListeners();

    imagePath = outputDir.path;
    return outputFile.path;
  }

  bool validate() {
    return formKey.currentState!.validate();
  }

  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
  }
}
