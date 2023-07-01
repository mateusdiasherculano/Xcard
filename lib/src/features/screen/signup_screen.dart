import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pdf_generator/src/components/custom_text_field.dart';
import 'package:pdf_generator/src/features/screen/signin_screen.dart';
import 'package:provider/provider.dart';

import '../../components/formatter.dart';
import '../controller/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final formatter = Formatter();
  final SignUpController _controller = SignUpController();
  bool _isFormValid = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Criação de Perfil',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            controller: _nomeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, digite o nome';
                              }
                              return null; // A validação passou
                            },
                          ),
                          CustomTextField(
                            icon: Icons.email,
                            label: 'E-mail',
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, digite o e-mail';
                              }
                              if (!EmailValidator.validate(value)) {
                                return 'E-mail inválido';
                              }
                              // Adicione outras validações de e-mail aqui, se necessário
                              return null; // A validação passou
                            },
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Password',
                            isSecret: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, digite a senha';
                              }
                              // Adicione outras validações de senha aqui, se necessário
                              return null; // A validação passou
                            },
                          ),
                          CustomTextField(
                            controller: _phoneController,
                            icon: Icons.phone,
                            label: 'Telefone',
                            inputFormatters: [formatter.phoneFormatter],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, digite o telefone';
                              }
                              // Adicione outras validações de telefone aqui, se necessário
                              return null; // A validação passou
                            },
                          ),
                          SizedBox(
                            height: 50,
                            child: Consumer<SignUpController>(
                              builder: (context, SignUpController, _) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () {
                                    _validateForm();
                                    _controller.submitForm(
                                      _formKey,
                                      _nomeController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _phoneController.text,
                                    );
                                    if (_isFormValid) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (c) {
                                        return SignInScreen();
                                      }));
                                    }
                                  },
                                  child: const Text(
                                    'Criar Perfil',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
