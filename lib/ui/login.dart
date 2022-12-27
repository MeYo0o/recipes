import 'package:flutter/material.dart';
import 'package:meyochat/data/user_dao.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MeYoChat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 80),

              //Email
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  autofocus: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is Required';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Email Address',
                  ),
                ),
              ),

              //Password
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _passwordController,
                      autofocus: false,
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is Required';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              //Login
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
// 1
                      onPressed: () async {
                        final errorMessage = await userDao.login(
                          _emailController.text,
                          _passwordController.text,
                        );
// 2
                        if (errorMessage != null) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(milliseconds: 700),
                            ),
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  )
                ],
              ),

              //Signup
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
// 3
                      onPressed: () async {
                        final errorMessage = await userDao.signup(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (errorMessage != null) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(milliseconds: 700),
                            ),
                          );
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
