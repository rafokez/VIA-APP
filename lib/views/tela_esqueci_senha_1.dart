import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaEsqueciSenha1 extends StatefulWidget {
  const TelaEsqueciSenha1({super.key});

  @override
  _TelaEsqueciSenha1State createState() => _TelaEsqueciSenha1State();
}

class _TelaEsqueciSenha1State extends State<TelaEsqueciSenha1> {
  final TextEditingController emailController = TextEditingController();

  Future<void> enviarCodigo() async {
    final String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira seu e-mail.')),
      );
      return;
    }

    // URL da API para enviar o código de redefinição de senha
    const String apiUrl = 'https://api-via.azurewebsites.net/api/conta/forgot-password';

    // Cria o corpo da requisição com o e-mail
    final Map<String, dynamic> data = {
      'email': email,
    };

    try {
      // Faz uma requisição POST para a API
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      // Verifica se a requisição foi bem-sucedida
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Código de autenticação enviado com sucesso!')),
        );
        // Navega para a próxima tela após o sucesso
        Navigator.pushNamed(context, '/esqueci_senha_2');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao enviar o código: ${response.body}')),
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
                const SizedBox(height: 50),
                const Text(
                  'Esqueceu sua senha?',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'lib/assets/image/imagemesqueceusenha.png',
                  height: 260,
                  width: 260,
                ),
                const SizedBox(height: 0),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Não se preocupe com isto.\n',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF737373),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                      TextSpan(
                        text: 'Vamos ajudá-lo a recuperá-la.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF737373),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  'Digite seu e-mail vinculado à sua conta:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email, color: Color(0xFF272A33)),
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
                const SizedBox(height: 16),
                const Text(
                  'Nós enviaremos um código de autenticação.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF737373),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTapDown: (_) {},
                  onTapUp: (_) {},
                  child: AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF272A33),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: enviarCodigo,
                      child: const Text(
                        'Avançar',
                        style: TextStyle(
                          color: Color(0xFFE7DDBF),
                          fontSize: 18,
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                    ),
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
