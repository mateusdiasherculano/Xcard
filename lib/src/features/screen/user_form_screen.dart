import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../controller/user_provider.dart';

class UserFormScreen extends StatefulWidget {
  @override
  State<UserFormScreen> createState() => _UserFormScreen();
}

class _UserFormScreen extends State<UserFormScreen> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final user = arg as User;
        _formData['id'] = user.id!;
        _formData['name'] = user.name;
        _formData['email'] = user.email;
        _formData['avatarUrl'] = user.avatarUrl;
        _formData['endereço'] = user.address;
        _formData['telefone'] = user.phone;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Formulário de Cliente'),
        actions: [
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name']!,
                    email: _formData['email']!,
                    avatarUrl: _formData['avatarUrl']!,
                    address: _formData['endereço']!,
                    phone: _formData['telefone']!,
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome inválido';
                  }
                  if (value.trim().length < 3) {
                    return 'Seu nome precisa ter no minimo 3 letras.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: const InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              ),
              TextFormField(
                initialValue: _formData['endereço'],
                decoration: const InputDecoration(labelText: 'Endereço'),
                onSaved: (value) => _formData['endereço'] = value!,
              ),
              TextFormField(
                initialValue: _formData['telefone'],
                decoration: const InputDecoration(labelText: 'Telefone'),
                onSaved: (value) => _formData['telefone'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
