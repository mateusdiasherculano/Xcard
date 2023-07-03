import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../controller/user_provider.dart';

class CadastroUserScreen extends StatelessWidget {
  final User user;

  const CadastroUserScreen(this.user, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: avatar,
          title: Text(user.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.email),
              Text(user.address),
              Text(user.phone),
            ],
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      'CadastroUsuario',
                      arguments: user,
                    );
                  },
                  icon: const Icon(Icons.edit),
                  color: Colors.orange,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Excluir Usuário'),
                        content: const Text('Tem certeza?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Não'),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<UsersProvider>(context, listen: false)
                                  .remove(user);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Sim'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
