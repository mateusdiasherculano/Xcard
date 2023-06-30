import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class SharedPreferencesHelper {
  final String nomeKey = 'nome';
  final String emailKey = 'email';
  final String passwordKey = 'password';
  final String phoneKey = 'telefone';
  final String avatarUrlKey = 'avatarUrl';


  // ... adicione as outras chaves aqui

  Future<void> saveFormData(
      String nome, String email, String password, String telefone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(nomeKey, nome);
    prefs.setString(emailKey, email);
    prefs.setString(passwordKey, password);
    prefs.setString(phoneKey, telefone);
  }




  Future<void> saveEmail(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(emailKey, email);
    prefs.setString(passwordKey, password);
  }

  Future<void> retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nome = prefs.getString('nome');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    String? telefone = prefs.getString('telefone');

    print('Dados salvos:');
    print('Nome: $nome');
    print('E-mail: $email');
    print('Password: $password');
    print('Telefone: $telefone');
  }

  Future<String?> getNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(nomeKey);
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey);
  }

  Future<String?> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(phoneKey);
  }
}
