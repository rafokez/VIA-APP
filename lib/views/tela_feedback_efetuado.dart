import 'package:flutter/material.dart';

class TelaFeedbackEfetuado extends StatelessWidget {
  const TelaFeedbackEfetuado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272A33), // Cor da Navbar de cima
        automaticallyImplyLeading: false, // Remove a seta de voltar
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              child: Center(
                child: Image.asset(
                  'lib/assets/image/logovia.png',
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 300, // Largura da linha branca
              height: 1,
              color: Colors.white,
              alignment: Alignment.centerRight, // Alinha a linha branca à direita
              margin: const EdgeInsets.only(right: 16), // Margem à direita
            ),
            const SizedBox(height: 10),
            const Text(
              'Feedbacks', // Título atualizado
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        toolbarHeight: 120, // Aumenta a altura da AppBar para acomodar os novos elementos
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFD8C8A9), // Cor de fundo bege
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 39, 39, 39),
              size: 250,
            ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Seu feedback foi enviado!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Sua opinião é muito importante para a nossa equipe!\nDeseja iniciar outro trajeto?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 30), // Espaço para o botão
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF272A33),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const Text(
              'Retornar a home',
              style: TextStyle(
                color: Color(0xFFE7DDBF),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
