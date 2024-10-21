import 'package:flutter/material.dart';

class TelaConseguimos extends StatefulWidget {
  const TelaConseguimos({super.key});

  @override
  _TelaConseguimosState createState() => _TelaConseguimosState();
}

class _TelaConseguimosState extends State<TelaConseguimos> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

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
                // Texto "Conseguimos!" maior e em cima da imagem
                const Center(
                  child: Text(
                    'Conseguimos!',
                    style: TextStyle(
                      fontSize: 32,  // Tamanho maior
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF272A33),
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Center(
                  child: Image.asset(
                    'lib/assets/image/imagemconseguimos.png',
                    height: 260,
                    width: 260,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Agora que está tudo certo...',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF737373),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 40),
                // Texto acima do primeiro campo de entrada com estilo atualizado
                const Text(
                  'Digite sua senha forte:',
                  style: TextStyle(
                    fontSize: 20, // Tamanho do texto ajustado
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
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
                      hintText: 'Digite sua senha',
                      filled: true,
                      fillColor: const Color(0xFFE7DDBF), // Cor do fundo igual à da tela
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFF272A33), width: 1),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'MinhaFonte'),
                  ),
                ),
                const SizedBox(height: 20),
                // Texto acima do segundo campo de entrada com estilo atualizado
                const Text(
                  'Confirme sua senha:',
                  style: TextStyle(
                    fontSize: 20, // Tamanho do texto ajustado
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
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
                      hintText: 'Confirme sua senha',
                      filled: true,
                      fillColor: const Color(0xFFE7DDBF), // Cor do fundo igual à da tela
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFF272A33), width: 1),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'MinhaFonte'),
                  ),
                ),
                const SizedBox(height: 40),
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
                        Navigator.pushNamed(context, '/feito'); // Navega para a tela de login
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
