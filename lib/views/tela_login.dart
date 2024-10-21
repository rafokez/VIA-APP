import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> loginUsuario() async {
  const String apiUrl = 'https://api-via.azurewebsites.net/api/conta/login';

  final Map<String, dynamic> data = {
    'email': emailController.text,
    'senha': senhaController.text,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Armazenando o token de autenticação e o email do usuário usando shared_preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', responseData['token']);
      await prefs.setString('email', emailController.text); // Armazenando o email

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );
      Navigator.pushNamed(context, '/home'); // Navega para a tela principal após o login
    } else {
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha no login: ${response.body}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao conectar com o servidor: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272A33),
        automaticallyImplyLeading: false, // Remove a seta de voltar
        title: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(90),
          ),
          child: Center(
            child: Image.asset(
              'lib/assets/image/logovia.png',
              height: 100,
              width: 100,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Image.asset(
                    'lib/assets/image/imagemlogin.png',
                    height: 260,
                    width: 260,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Aplicativo VIA',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF272A33),
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Digite seu e-mail:',
                  style: TextStyle(
                    fontSize: 20, // Tamanho menor que o título
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Color(0xFF272A33)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Digite seu e-mail',
                      filled: true,
                      fillColor: const Color(0xFFE7DDBF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFF272A33), width: 1),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'MinhaFonte'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Digite sua senha:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: senhaController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF272A33)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF272A33),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Digite sua senha',
                      filled: true,
                      fillColor: const Color(0xFFE7DDBF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFF272A33), width: 1),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'MinhaFonte'),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/esqueci_senha_1');
                  },
                  child: const Text(
                    'Esqueci minha senha!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF272A33),
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: loginUsuario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF272A33),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      color: Color(0xFFE7DDBF),
                      fontSize: 18,
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    '© Equipe Legacy - Todos os direitos reservados VIA 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF737373),
                      fontFamily: 'MinhaFonte',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE7DDBF),
    );
  }
}
