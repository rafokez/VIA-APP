import 'package:flutter/material.dart';

class TelaBemVindo extends StatelessWidget {
  const TelaBemVindo({super.key});

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
                // Imagem centralizada abaixo da AppBar
                Image.asset(
                  'lib/assets/image/imagemlogin.png',
                  height: 260,
                  width: 260,
                ),
                const SizedBox(height: 20),
                // Texto "Bem-vindo(a)!"
                const Text(
                  'Bem-vindo(a)!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 20),
                // Frase dividida em duas linhas
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Cadastre-se e confira todas as vantagens\n',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF737373),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                      TextSpan(
                        text: 'do usuário ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF737373),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                      TextSpan(
                        text: 'VIA',
                        style: TextStyle(
                          color: Color(0xFF272A33),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Botão de login
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF272A33),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login'); // Navega para a tela de login
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      color: Color(0xFFE7DDBF),
                      fontSize: 18,
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Aumenta o espaçamento entre o botão de login e o texto "Cadastre-se"
                // Texto "Cadastre-se" com navegação
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/cadastro_usuario_1'); // Navega para a tela de cadastro de usuário 1
                  },
                  child: const Text(
                    'Cadastre-se',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF272A33),
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Linha com "OU"
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Color(0xFF737373),
                        thickness: 1,
                        indent: 40,
                        endIndent: 20,
                      ),
                    ),
                    Text(
                      "OU",
                      style: TextStyle(color: Color(0xFF737373)),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF737373),
                        thickness: 1,
                        indent: 20,
                        endIndent: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30), // Afasta a linha um pouco mais para baixo
                // Ícones do Google e Apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('lib/assets/image/Google.png'),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20), // Espaçamento entre os ícones
                    IconButton(
                      icon: Image.asset('lib/assets/image/Apple.png'),
                      onPressed: () {},
                    ),
                  ],
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
