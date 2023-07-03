import 'package:flutter/material.dart';
import 'package:pdf_generator/src/features/controller/signin_controller.dart';
import 'package:provider/provider.dart';

import '../core/routes.dart';
import '../features/controller/cadastro_model_controller.dart';
import '../features/controller/cadastro_user_controller.dart';
import '../features/controller/create_perfil_controller.dart';
import '../features/controller/user_provider.dart';
import '../features/screen/signin_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInController>(
            create: (_) => SignInController()),
        ChangeNotifierProvider<SignUpController>(
            create: (_) => SignUpController()),
        ChangeNotifierProvider<CadastroUserController>(
            create: (_) => CadastroUserController()),
        ChangeNotifierProvider<ModelRegistrationController>(
            create: (_) => ModelRegistrationController()),
        ChangeNotifierProvider<UsersProvider>(create: (_) => UsersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: SignInScreen(),
        //onGenerateRoute: ,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
