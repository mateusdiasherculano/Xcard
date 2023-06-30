import 'package:flutter/material.dart';

import '../../components/formatter.dart';

class CadastroUserController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formatter = Formatter();

  @override
  void dispose() {
    super.dispose();
    nomeController.dispose();
    telefoneController.dispose();
    enderecoController.dispose();
    emailController.dispose();
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void salvarCadastro() {
    if (validateForm()) {
      final nome = nomeController.text;
      final telefone = telefoneController.text;
      final endereco = enderecoController.text;
      final email = emailController.text;
      notifyListeners();

      // Chamada para salvar os dados em SharedPreferences ou em outro lugar

      // Exemplo de exibição dos dados salvos no console
      print('Nome: $nome');
      print('Telefone: $telefone');
      print('Endereço: $endereco');
      print('E-mail: $email');
    }
  }
}
