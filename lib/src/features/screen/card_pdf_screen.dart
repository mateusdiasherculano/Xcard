import 'package:flutter/material.dart';

class CardPdfScreen extends StatelessWidget {
  final String cardModel;
  final String city;
  final String sex;
  final DateTime dateOfBirth;
  final String imageUrl;
  final String pdfPath;

  const CardPdfScreen({
    Key? key,
    required this.cardModel,
    required this.city,
    required this.sex,
    required this.dateOfBirth,
    required this.imageUrl,
    required this.pdfPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartões Personalizados'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modelo do Cartão: $cardModel',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Cidade: $city',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Sexo: $sex',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Data de Aniversário: ${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}',
              style: TextStyle(fontSize: 18),
            ),
            // Resto do código para exibir os cartões personalizados
          ],
        ),
      ),
    );
  }
}
