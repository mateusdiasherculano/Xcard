import 'package:flutter/material.dart';

import '../../core/data_management.dart';

class GeradorPDF extends StatefulWidget {
  const GeradorPDF({Key? key}) : super(key: key);

  @override
  _GeradorPDFState createState() => _GeradorPDFState();
}

class _GeradorPDFState extends State<GeradorPDF> {
  String? selectedCardModel;
  String? selectedCity;
  String? selectedSex;
  DateTime? selectedDate;

  List<String> cardModels = [];
  List<String> cities = [];
  List<String> sexes = [];

  final dataManagement = DataManagement();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final cardModelsData = await dataManagement.getCardModels();
      final citiesData = await dataManagement.getCities();
      final sexesData = await dataManagement.getSexes();

      setState(() {
        cardModels = cardModelsData.map((model) => model.name).toList();
        cities = citiesData;
        sexes = sexesData;
      });
    } catch (e) {
      // Trate qualquer erro de carregamento dos dados do banco de dados
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('Falha ao carregar os dados do banco de dados.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador PDF'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 230,
                child: Card(
                  elevation: 2,
                  child: DropdownButton<String>(
                    value: selectedCardModel,
                    hint: const Text(
                      'Modelo do Cartão',
                      style: TextStyle(fontSize: 18),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: const SizedBox(),
                    onChanged: (value) {
                      setState(() {
                        selectedCardModel = value;
                      });
                    },
                    items: cardModels.map((String model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Text(model),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 230,
                child: Card(
                  elevation: 2,
                  child: DropdownButton<String>(
                    value: selectedCity,
                    hint: const Text(
                      'Cidade',
                      style: TextStyle(fontSize: 18),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: const SizedBox(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                    items: cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 230,
                child: Card(
                  elevation: 2,
                  child: DropdownButton<String>(
                    value: selectedSex,
                    hint: const Text(
                      'Sexo',
                      style: TextStyle(fontSize: 18),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: const SizedBox(),
                    onChanged: (value) {
                      setState(() {
                        selectedSex = value;
                      });
                    },
                    items: sexes.map((String sex) {
                      return DropdownMenuItem<String>(
                        value: sex,
                        child: Text(sex),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                child: selectedDate == null
                    ? const Text('Selecionar Data de Aniversário')
                    : Text(
                        'Data selecionada: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                onPressed: () {
                  _selectDate(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Lógica para gerar o PDF com as informações
          print('Card Model: $selectedCardModel');
          print('City: $selectedCity');
          print('Sex: $selectedSex');
          print('Date of Birth: $selectedDate');
        },
        label: const Text('Gerar PDF'),
        icon: const Icon(Icons.picture_as_pdf),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
