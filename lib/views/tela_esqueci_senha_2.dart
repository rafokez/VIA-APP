import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaEsqueciSenha2 extends StatefulWidget {
  const TelaEsqueciSenha2({super.key});

  @override
  _TelaEsqueciSenha2State createState() => _TelaEsqueciSenha2State();
}

class _TelaEsqueciSenha2State extends State<TelaEsqueciSenha2> {
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController novaSenhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController(); // Controller para o email

  Future<void> resetPassword() async {
    final String email = emailController.text.trim();
    final String token = tokenController.text.trim();
    final String newPassword = novaSenhaController.text.trim();

    if (email.isEmpty || token.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    // URL da API para redefinir a senha
    const String apiUrl = 'https://api-via.azurewebsites.net/api/conta/reset-password';

    // Cria o corpo da requisição
    final Map<String, dynamic> data = {
      'email': email,
      'token': token,
      'newPassword': newPassword,
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
          const SnackBar(content: Text('Senha redefinida com sucesso!')),
        );
        // Navega para a tela de feito após o sucesso
        Navigator.pushNamed(context, '/feito');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao redefinir a senha: ${response.body}')),
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
        backgroundColor: const Color(0xFF272A33), // Cor da navbar ajustada
        automaticallyImplyLeading: false, // Remove a seta de voltar
        title: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(90),
          ),
          child: Center(
            child: Image.asset(
              'lib/assets/image/logovia.png', // Imagem da navbar ajustada
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
                // Título "Esqueceu sua senha?" ajustado
                const Text(
                  'Esqueceu sua senha?',
                  style: TextStyle(
                    fontSize: 32, // Fonte maior
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 20),
                // Imagem centralizada abaixo do título
                Image.asset(
                  'lib/assets/image/imagemesqueceusenha.png', // Imagem padronizada
                  height: 260,
                  width: 260,
                ),
                const SizedBox(height: 10), // Menos espaço entre a imagem e a frase
                // Frase dividida em duas linhas
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Enviamos um código a você.\n',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF737373),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                      TextSpan(
                        text: 'Cheque sua caixa de entrada ou spam!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF737373),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Novo texto
                const Text(
                  'Digite o código enviado por email:',
                  style: TextStyle(
                    fontSize: 20, // Tamanho menor que o título
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de entrada para o código
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: tokenController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Digite o código',
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      filled: true,
                      fillColor: const Color(0xFFE7DDBF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF272A33),
                          width: 1,
                        ),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'MinhaFonte'),
                  ),
                ),
                const SizedBox(height: 16),
                // Novo texto para a nova senha
                const Text(
                  'Digite sua nova senha:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de entrada para a nova senha
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: novaSenhaController,
                    obscureText: true, // Para esconder a senha
                    decoration: InputDecoration(
                      hintText: 'Digite sua nova senha',
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      filled: true,
                      fillColor: const Color(0xFFE7DDBF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF272A33),
                          width: 1,
                        ),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'MinhaFonte'),
                  ),
                ),
                const SizedBox(height: 16),
                // Frase abaixo dos campos de entrada
                const Text(
                  'Certifique-se de que o código e a nova senha estão corretos.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF737373),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 30),
                // Botão para avançar com efeito de hover
                GestureDetector(
                  onTapDown: (_) {
                    // Lógica para animação ao clicar
                  },
                  onTapUp: (_) {
                    // Lógica para animação ao clicar
                  },
                  child: AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF272A33), // Cor do botão
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: resetPassword,
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
      backgroundColor: const Color(0xFFE7DDBF), // Cor de fundo ajustada
    );
  }
}
