import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pdf_generator/src/features/screen/home_screen.dart';
import 'package:pdf_generator/src/features/screen/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_field.dart';
import '../controller/signin_controller.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignInController _controller = SignInController();
  bool _isFormValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 40,
                          ),
                          children: [
                            TextSpan(
                              text: 'Xcard',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: DefaultTextStyle(
                          style: const TextStyle(fontSize: 25),
                          child: AnimatedTextKit(
                            pause: Duration.zero,
                            repeatForever: true,
                            animatedTexts: [
                              FadeAnimatedText(
                                'Marcando momentos',
                              ),
                              FadeAnimatedText('Marcando momentos'),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        icon: Icons.email,
                        label: 'E-mail',
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
                        controller: _passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite a senha';
                          }
                          // Adicione outras validações de senha aqui, se necessário
                          return null; // A validação passou
                        },
                      ),
                      SizedBox(
                          height: 50,
                          child: Consumer<SignInController>(
                              builder: (context, SignInController, _) {
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
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                if (_isFormValid) {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (c) {
                                    return const HomeScreen();
                                  }));
                                }
                              },
                              child: const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          })),
                      /*Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.orange,
                            ),
                          ),
                          onPressed: () {
                            _controller.submitForm(
                              _formKey,
                              _emailController.text,
                              _passwordController.text,
                            );
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (c) {
                              return const SignUpScreen();
                            }));
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
