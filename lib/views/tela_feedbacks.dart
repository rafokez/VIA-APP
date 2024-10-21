import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TelaFeedbacks extends StatefulWidget {
  const TelaFeedbacks({Key? key}) : super(key: key);

  @override
  _TelaFeedbacksState createState() => _TelaFeedbacksState();
}

class _TelaFeedbacksState extends State<TelaFeedbacks> {
  List<dynamic> _feedbacks = []; // Lista para armazenar os feedbacks

  @override
  void initState() {
    super.initState();
    _carregarFeedbacks(); // Chama a função ao iniciar a tela
  }

  Future<void> _carregarFeedbacks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado.')),
      );
      return;
    }

    const String apiUrl = 'https://api-via.azurewebsites.net/api/feedback/history';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> feedbacksList = jsonDecode(response.body);
        
        // Log para ver a estrutura dos dados retornados
        print('Feedbacks retornados: $feedbacksList');

        setState(() {
          _feedbacks = feedbacksList; // Atualiza a lista de feedbacks
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar feedbacks: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7DDBF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF272A33),
        title: const Text(
          'Seus Feedbacks',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // Altera a cor do ícone para branco
      ),
      body: SingleChildScrollView(
        // Adicionado SingleChildScrollView
        child: Column(
          children: [
            if (_feedbacks.isEmpty)
              const Center(child: CircularProgressIndicator()) // Mostra um loading enquanto carrega
            else
              ..._feedbacks.map((feedback) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feedback['comentario'] ?? 'Comentário não disponível',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 4),
                        Text(
                          'Data: ${feedback['data'] ?? 'Data não disponível'}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true, // Permite que a tela se ajuste quando o teclado é exibido
    );
  }
}
