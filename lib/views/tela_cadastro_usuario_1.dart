import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaCadastroUsuario1 extends StatefulWidget {
  const TelaCadastroUsuario1({super.key});

  @override
  _TelaCadastroUsuario1State createState() => _TelaCadastroUsuario1State();
}

class _TelaCadastroUsuario1State extends State<TelaCadastroUsuario1> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dataNascimentoController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  // Configuração para a máscara de telefone no formato (XX)XXXXX-XXXX
  final maskFormatter = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<void> registrarUsuario() async {
  // Verifica se as senhas são iguais
  if (senhaController.text != confirmarSenhaController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('As senhas não coincidem!')),
    );
    return;
  }

  // Verifica se o número de telefone está em um formato válido
  String phoneNumber = phoneNumberController.text;
  if (!RegExp(r'^\(\d{2}\)\d{4,5}-\d{4}$').hasMatch(phoneNumber)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Número de telefone inválido. Use o formato (XX)XXXXX-XXXX ou (XX)XXXX-XXXX.')),
    );
    return;
  }

  // URL da API para o registro de usuário
  const String apiUrl = 'https://api-via.azurewebsites.net/api/conta/register';

  // Cria o corpo da requisição com os dados do usuário
  final Map<String, dynamic> data = {
    'nome': nomeController.text,
    'email': emailController.text,
    'dataNascimento': dataNascimentoController.text,
    'cpf': cpfController.text,
    'phoneNumber': phoneNumber,
    'senha': senhaController.text,
    'confirmarSenha': confirmarSenhaController.text,
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

    // Verifica se o cadastro foi bem-sucedido
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);

      // Verifica se a resposta contém um token de autenticação
      if (responseData.containsKey('token') || responseData.containsKey('authToken')) {
        // Suponha que o token pode estar em diferentes campos, então verifique ambos
        String token = responseData['token'] ?? responseData['authToken'];

        // Armazena o token de autenticação no SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );

        // Redireciona para a tela de cadastro efetuado
        Navigator.pushNamed(context, '/cadastro_efetuado');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha no cadastro: Token não encontrado.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha no cadastro: ${response.body}')),
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
        title: SizedBox(
          height: 50,
          child: Center(
            child: Image.asset(
              'lib/assets/image/logovia.png',
              height: 60,
              width: 60,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Digite seu email',
                  ),
                ),
                TextField(
                  controller: dataNascimentoController,
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    hintText: 'AAAA-MM-DD',
                  ),
                ),
                TextField(
                  controller: cpfController,
                  decoration: InputDecoration(
                    labelText: 'CPF',
                    hintText: 'Digite seu CPF',
                  ),
                ),
                TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [maskFormatter],
                  decoration: InputDecoration(
                    labelText: 'Número de Telefone',
                    hintText: '(XX)XXXXX-XXXX',
                  ),
                ),
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                  ),
                ),
                TextField(
                  controller: confirmarSenhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    hintText: 'Confirme sua senha',
                  ),
                ),
                ElevatedButton(
                  onPressed: registrarUsuario,
                  child: const Text('Avançar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
