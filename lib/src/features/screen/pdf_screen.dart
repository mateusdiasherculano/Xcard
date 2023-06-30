import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_extend/share_extend.dart';

class PDFScreen extends StatelessWidget {
  final String pdfPath;

  const PDFScreen({required this.pdfPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Pronto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Implementar o compartilhamento do PDF aqui
              ShareExtend.share(pdfPath, 'file', sharePanelTitle: 'Enviar PDF');
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Container(
        // Exibir o PDF aqui
        child: PDFView(
          filePath: pdfPath,
        ),
      ),
    );
  }
}
