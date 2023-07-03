import 'package:flutter/material.dart';

import '../../core/shared_preferens.dart';

class SignUpController extends ChangeNotifier {
  final shared = SharedPreferencesHelper();

  void submitForm(GlobalKey<FormState> formKey, String nome, String email,
      String password, String phone) {
    if (formKey.currentState!.validate()) {
      // Todos os campos são válidos, prosseguir com a criação do perfil
      shared.saveFormData(nome, email, password, phone);
      shared.retrieveData();
      notifyListeners();
    }
  }
}
