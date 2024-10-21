import 'package:flutter/material.dart';

class TelaFeito extends StatelessWidget {
  const TelaFeito({super.key});

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
        automaticallyImplyLeading: false,  // Remove a seta de voltar
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
                // Título "Feito!" em cima da imagem
                const Text(
                  'Feito!',
                  style: TextStyle(
                    fontSize: 32,  // Tamanho maior
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'lib/assets/image/imagemfeito.png',
                    height: 260,
                    width: 260,
                  ),
                ),
                const SizedBox(height: 45),
                // Frases abaixo da imagem com a palavra VIA em destaque
                const Text(
                  'Senha nova, vida nova.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF737373),
                    fontFamily: 'MinhaFonte',
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Desfrute de todas as funcionalidades',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF737373),
                    fontFamily: 'MinhaFonte',
                  ),
                  textAlign: TextAlign.center,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'do aplicativo ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF737373),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                      TextSpan(
                        text: 'VIA!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF272A33),  // Cor do título
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Linha fina abaixo da frase
                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: const Color(0xFF272A33),
                ),
                const SizedBox(height: 80),
                // Botão "Avançar"
                GestureDetector(
                  onTapDown: (_) {
                    // Logic for small animation
                  },
                  onTapUp: (_) {
                    // Logic for small animation
                  },
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
                      onPressed: () {
                        // Navegar para a tela de login
                        Navigator.pushNamed(context, '/login');
                      },
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
