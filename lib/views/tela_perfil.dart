import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'tela_login.dart'; // Importe a tela de login

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  _TelaPerfil createState() => _TelaPerfil();
}

class _TelaPerfil extends State<TelaPerfil> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool isEditing = false; // Estado para verificar se está em modo de edição

  // Controladores para os campos de texto
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dataNascimentoController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token != null) {
        String apiUrl = 'https://api-via.azurewebsites.net/api/user/current';
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          setState(() {
            userData = jsonDecode(response.body);
            isLoading = false;

            // Preenche os controladores com os dados do usuário
            nomeController.text = userData!['nome'];
            emailController.text = userData!['email'];
            dataNascimentoController.text = userData!['dataNascimento'];
            phoneNumberController.text = userData!['phoneNumber'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao carregar os dados do usuário: ${response.body}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Token de autenticação não encontrado. Faça login novamente.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao conectar com o servidor: $e')),
      );
    }
  }

  Future<void> _updateUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token != null) {
        String apiUrl = 'https://api-via.azurewebsites.net/api/user/update';
        final Map<String, dynamic> data = {
          'nome': nomeController.text,
          'email': emailController.text,
          'dataNascimento': dataNascimentoController.text,
          'phoneNumber': phoneNumberController.text,
        };

        final response = await http.put(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dados atualizados com sucesso!')),
          );

          // Exibe mensagem de alerta e redireciona para a tela de login
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Atenção'),
              content: const Text('Dados alterados. Faça login novamente!'),
              actions: [
                TextButton(
                  onPressed: () async {
                    // Limpa os dados do usuário e redireciona para a tela de login
                    await prefs.remove('authToken');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaLogin()), // Substitua TelaLogin pela sua tela de login
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );

          setState(() {
            isEditing = false; // Volta ao modo de visualização após a atualização
          });
          _fetchUserData(); // Atualiza os dados após a edição
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao atualizar os dados: ${response.body}')),
          );
        }
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
        title: const Text('Perfil do Usuário', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF272A33),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Botão para voltar à tela anterior
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isEditing) ...[
                            // Exibe os dados do usuário se não estiver em modo de edição
                            Text(
                              'Nome: ${userData!['nome']}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'E-mail: ${userData!['email']}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Data de Nascimento: ${userData!['dataNascimento']}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Número de Telefone: ${userData!['phoneNumber']}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = true; // Muda para modo de edição
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF272A33),
                                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 23),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 5,
                              ),
                              child: const Text(
                                'Editar Dados',
                                style: TextStyle(color: Color(0xFFE7DDBF)),
                              ),
                            ),
                          ] else ...[
                            // Exibe os campos de edição se estiver em modo de edição
                            TextField(
                              controller: nomeController,
                              decoration: InputDecoration(
                                labelText: 'Nome',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: const Color(0xFFE7DDBF),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF272A33)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: const Color(0xFFE7DDBF),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF272A33)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: dataNascimentoController,
                              decoration: InputDecoration(
                                labelText: 'Data de Nascimento (YYYY-MM-DD)',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: const Color(0xFFE7DDBF),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF272A33)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                labelText: 'Número de Telefone',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: const Color(0xFFE7DDBF),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF272A33)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _updateUserData,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF272A33),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 5,
                              ),
                              child: const Text(
                                'Atualizar Dados',
                                style: TextStyle(color: Color(0xFFE7DDBF)),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text('Erro ao carregar os dados do usuário.'),
                ),
    );
  }
}
