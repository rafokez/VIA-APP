import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TelaAlterarSenha extends StatefulWidget {
  const TelaAlterarSenha({super.key});

  @override
  _TelaAlterarSenhaState createState() => _TelaAlterarSenhaState();
}

class _TelaAlterarSenhaState extends State<TelaAlterarSenha> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final TextEditingController novaSenhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  void _togglePasswordVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  Future<void> alterarSenha() async {
    const String apiUrl = 'https://api-via.azurewebsites.net/api/conta/reset-password';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email'); // Supondo que você armazene o email
    String? token = prefs.getString('authToken');

    print('Email: $email'); // Para depuração
    print('Token: $token'); // Para depuração

    if (email == null || token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou token não encontrados.')),
      );
      return;
    }

    if (novaSenhaController.text != confirmarSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não correspondem!')),
      );
      return;
    }

    final Map<String, dynamic> data = {
      'email': email, // Captura o email do usuário logado
      'token': token, // Captura o token do usuário logado
      'newPassword': novaSenhaController.text, // Nova senha
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha alterada com sucesso!')),
        );
        Navigator.pushNamed(context, '/feito'); // Navega para a tela de confirmação
      } else {
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao alterar a senha: ${response.body}')),
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
                const Center(
                  child: Text(
                    'Alterar senha',
                    style: TextStyle(
                      fontSize: 32, // Tamanho maior
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF272A33),
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Center(
                  child: Image.asset(
                    'lib/assets/image/imagemesquecisenha.png',
                    height: 280,
                    width: 280,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lembre-se: Coloque uma senha segura!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF737373),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Digite sua nova senha:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: novaSenhaController,
                    obscureText: _obscureText1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF272A33)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText1 ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF272A33),
                        ),
                        onPressed: _togglePasswordVisibility1,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Digite sua nova senha',
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
                  'Confirme sua nova senha:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: confirmarSenhaController,
                    obscureText: _obscureText2,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF272A33)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText2 ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF272A33),
                        ),
                        onPressed: _togglePasswordVisibility2,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Confirme sua nova senha',
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
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: alterarSenha,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF272A33),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Alterar senha',
                    style: TextStyle(
                      color: Color(0xFFE7DDBF),
                      fontSize: 18,
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  '© Equipe Legacy - Todos os direitos reservados VIA 2024',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF737373),
                    fontFamily: 'MinhaFonte',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE7DDBF),
    );
  }
}
