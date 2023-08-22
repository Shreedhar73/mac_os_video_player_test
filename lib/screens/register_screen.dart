import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/register/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Screen"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.of(context).pop();
                    } else if (state is RegisterError) {
                      log("Error: ${state.errorMessage}");
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        _form.currentState!.save();
                        if (_form.currentState!.validate()) {
                          context.read<RegisterBloc>().add(
                                RegisterWithEmailAndPasswordEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                      child: const Text("Register"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
