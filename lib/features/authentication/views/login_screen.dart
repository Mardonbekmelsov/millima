import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/auth/login_request.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';
import 'package:millima/features/authentication/views/register_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    final phone = _phoneController.text;
    final password = _passwordController.text;

    if (phone.isEmpty) {
      _showErrorSnackBar(context, 'Phone Field cannot be empty!');
      return;
    }
    if (password.isEmpty) {
      _showErrorSnackBar(context, 'Password cannot be empty!');
      return;
    }

    context.read<AuthenticationBloc>().add(LoginEvent(
          request: LoginRequest(
            phone: phone,
            password: password,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            FilledButton(
              onPressed: () => _handleLogin(context),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
