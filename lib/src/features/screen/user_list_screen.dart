import 'package:flutter/material.dart';
import 'package:pdf_generator/src/features/screen/user_form_screen.dart';
import 'package:provider/provider.dart';

import '../controller/user_provider.dart';
import 'cadastro_user.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de clientes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                return UserFormScreen();
              }));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: users.count > 0
          ? ListView.builder(
              itemBuilder: (ctx, i) => CadastroUserScreen(users.byIndex(i)),
              itemCount: users.count,
            )
          : const Center(
              child: Text(
                'Nenhum cliente cadastrado',
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}
