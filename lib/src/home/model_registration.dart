import 'package:flutter/material.dart';

import '../features/controller/model_registration_controller.dart';
import '../features/screen/pdf_screen.dart';

class ModelRegistrationScreen extends StatefulWidget {
  const ModelRegistrationScreen({Key? key}) : super(key: key);

  @override
  _ModelRegistrationScreenState createState() =>
      _ModelRegistrationScreenState();
}

class _ModelRegistrationScreenState extends State<ModelRegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  bool isLoading = false;
  final logic = ModelRegistrationController();

  @override
  void dispose() {
    nameController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void _createPDF() async {
    if (validate()) {
      final name = nameController.text;
      final imageURL = imageUrlController.text;

      setState(() {
        isLoading = true;
      });

      logic.createPDF(name, imageURL).then((pdfPath) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PDFScreen(pdfPath: pdfPath);
        }));
      }).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  bool validate() {
    return formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador PDF'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira um nome.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: imageUrlController,
                      decoration:
                          const InputDecoration(labelText: 'URL da imagem'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma URL de imagem.';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: isLoading ? null : _createPDF,
                      child: const Text('Criar PDF'),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
