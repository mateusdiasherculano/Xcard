import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/cadastro_model_controller.dart';

class CadastroModelScreen extends StatefulWidget {
  const CadastroModelScreen({Key? key}) : super(key: key);

  @override
  _CadastroModelScreenState createState() => _CadastroModelScreenState();
}

class _CadastroModelScreenState extends State<CadastroModelScreen> {
  final formKey = GlobalKey<FormState>();
  File? imageFile;
  bool isLoading = false;
  final controller = CadastroModelController();

  @override
  void dispose() {
    super.dispose();
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void _createPDF(BuildContext context) async {
    if (validate()) {
      setState(() {
        isLoading = true;
      });

      await controller.createPDF(imageFile);

      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cartão de modelo PDF criado com sucesso'),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
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
        title: const Text('Modelo PDF'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Selecionar Imagem'),
                        ),
                        if (imageFile != null)
                          Image.file(
                            imageFile!,
                            height: 200,
                          ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : () => _createPDF(context),
                  child: const Text('Criar Modelo PDF'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
