import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EmailFormPage(),
    );
  }
}

class EmailFormPage extends StatefulWidget {
  const EmailFormPage({super.key});

  @override
  State<EmailFormPage> createState() => _EmailFormPageState();
}

class _EmailFormPageState extends State<EmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _validationMessage = '';

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _validateEmail() {
    final email = _emailController.text;
    if (email.isEmpty) {
      setState(() {
        _validationMessage = 'Lütfen bir email adresi girin';
      });
    } else if (!_isValidEmail(email)) {
      setState(() {
        _validationMessage = 'Geçerli bir email adresi girin';
      });
    } else {
      setState(() {
        _validationMessage = 'Email adresi geçerli';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Doğrulama'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'ornek@email.com',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) => _validateEmail(),
              ),
              const SizedBox(height: 20),
              Text(
                _validationMessage,
                style: TextStyle(
                  color: _validationMessage.contains('geçerli')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _validateEmail();
                  }
                },
                child: const Text('Doğrula'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
