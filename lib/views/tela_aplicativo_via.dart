import 'package:flutter/material.dart';

class TelaConcluidoAlteracao extends StatelessWidget {
  const TelaConcluidoAlteracao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alteração Concluída'),
        backgroundColor: const Color(0xFF001F49), // Cor de fundo do AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'Conseguimos!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Agora que está tudo certo, digite uma nova senha forte.'),
            // Botão Avançar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001F49), // Cor do botão
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Lógica de confirmação de alteração de senha
              },
              child: const Text(
                'Avançar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
