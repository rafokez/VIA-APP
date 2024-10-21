import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_in_flutter/views/tela_feedback_efetuado.dart';

class TelaCadastroFeedback extends StatefulWidget {
  const TelaCadastroFeedback({Key? key}) : super(key: key);

  @override
  _TelaCadastroFeedbackState createState() => _TelaCadastroFeedbackState();
}

class _TelaCadastroFeedbackState extends State<TelaCadastroFeedback> {
  double _selectedStars = 1; // Armazena o número de estrelas (1 a 5)
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> enviarFeedback() async {
    // Verifica se o número de estrelas está entre 1 e 5
    if (_selectedStars < 1 || _selectedStars > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A nota deve estar entre 1 e 5 estrelas.')),
      );
      return;
    }

    // Verifica se o feedback foi preenchido
    if (_feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O comentário é obrigatório.')),
      );
      return;
    }

    // Recupera o token do usuário autenticado
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado.')),
      );
      return;
    }

    const String apiUrl = 'https://api-via.azurewebsites.net/api/feedback/create-feedback';

    // Formata a data no formato ISO 8601
    String formattedDate = DateTime.now().toIso8601String();

    final Map<String, dynamic> feedbackData = {
      'comentario': _feedbackController.text,
      'nota': _selectedStars.round(), // Arredonda a nota para inteiro
      'data': formattedDate,
    };

    // Adicionando um log para ver os dados enviados
    print('Enviando Feedback: ${feedbackData.toString()}');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(feedbackData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback enviado com sucesso!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TelaFeedbackEfetuado()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar feedback: ${response.body}')),
        );
        print('Response body: ${response.body}');
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
        title: const Text('Feedback'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF272A33),
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Trajeto de Quinta-Feira às 14h32 Linha Lilás',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Descreva sua experiência e sugestões.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Adicionando o Slider
            Column(
              children: [
                const Text(
                  'Nota: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _selectedStars,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _selectedStars.round().toString(),
                  activeColor: const Color(0xFF272A33),
                  onChanged: (double value) {
                    setState(() {
                      _selectedStars = value;
                    });
                  },
                ),
                Text(
                  'Você deu $_selectedStars estrelas',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: enviarFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF272A33),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Enviar feedback',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lembre-se de destacar pontos positivos e negativos.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
