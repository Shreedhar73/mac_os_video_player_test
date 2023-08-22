import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realm_test/config/realm_config.dart';
import 'package:flutter_realm_test/controller/login/login_bloc.dart';
import 'package:flutter_realm_test/models/person.dart';
import 'package:flutter_realm_test/screens/home_screen.dart';
import 'package:flutter_realm_test/screens/register_screen.dart';
import 'package:realm/realm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _form = GlobalKey<FormState>();
  late App app;

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
        title: const Text("Login Screen"),
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
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      log("LoggedIn User: ${state.user!.id.toString()}");
                      final loggedInUser = state.user;
                      final config = Configuration.flexibleSync(
                        loggedInUser!,
                        [Person.schema],
                      );
                      RealmConfig.instance.realmHelper = Realm(config);
                      RealmConfig.instance.subscription();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else if (state is LoginError) {
                      log("Login Error: ${state.errorMessage.toString()}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.errorMessage.toString(),
                          ),
                        ),
                      );
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () async {
                      _form.currentState!.save();
                      if (_form.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                              LoginWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text("New User? Sign Up Here"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
