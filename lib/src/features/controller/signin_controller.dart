import 'package:flutter/cupertino.dart';

import '../../core/shared_preferens.dart';

class SignInController extends ChangeNotifier {
  final shared = SharedPreferencesHelper();

  void submitForm(GlobalKey<FormState> formKey, String email, String password) {
    if (formKey.currentState!.validate()) {
      // Todos os campos são válidos, prosseguir com o login
      shared.saveEmail(email, password);
      shared.retrieveData();
      notifyListeners();
    }
  }
}
