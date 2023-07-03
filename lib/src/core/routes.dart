import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/screen/cadastro_model_screen.dart';
import '../features/screen/create_perfil_screen.dart';
import '../features/screen/gerador_pdf_screen.dart';
import '../features/screen/menu_principal.dart';
import '../features/screen/user_list_screen.dart';

class Routes {
  // static const USER_FORM = '/user-form';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'TelaHome':
        return MaterialPageRoute(builder: (_) => MenuPrincipal());
      case 'CadastroCliente':
        return MaterialPageRoute(builder: (_) => const UserListScreen());
      case 'CadastroUsuario':
        return MaterialPageRoute(builder: (_) => const CreatePerfilScreen());
      case 'CadastroModeloPDF':
        return MaterialPageRoute(builder: (_) => const CadastroModelScreen());
      case 'geradorPDF':
        return MaterialPageRoute(builder: (_) => const GeradorPDF());
    }
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      );
    });
  }
}
