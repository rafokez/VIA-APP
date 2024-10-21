import 'package:flutter/material.dart';

class TelaCadastroUsuario2 extends StatelessWidget {
  const TelaCadastroUsuario2({super.key});

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
        automaticallyImplyLeading: false, // Remove a seta de voltar
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Título centralizado
                const Text(
                  'Cadastro de Usuário',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 8),
                // Linha abaixo do título
                Container(
                  width: 200,
                  height: 1,
                  color: const Color(0xFF272A33),
                ),
                const SizedBox(height: 8),
                // Subtítulo centralizado
                const Text(
                  'Informações Confidenciais',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF272A33),
                    fontFamily: 'MinhaFonte',
                  ),
                ),
                const SizedBox(height: 30),
                // Imagem centralizada e aumentada
                SizedBox(
                  width: 200,  // Ajuste o tamanho da imagem conforme necessário
                  height: 200,  // Ajuste o tamanho da imagem conforme necessário
                  child: Image.asset(
                    'lib/assets/image/imagemcadastro.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                // CPF
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CPF:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF272A33),
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity, // Ajusta para a largura disponível
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.credit_card, color: Color(0xFF272A33)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Digite seu CPF',
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
                const SizedBox(height: 16),
                // Data de Nascimento
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data de Nascimento:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF272A33),
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity, // Ajusta para a largura disponível
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF272A33)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Digite sua data de nascimento',
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
                const SizedBox(height: 16),
                // Telefone
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Telefone:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF272A33),
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity, // Ajusta para a largura disponível
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone, color: Color(0xFF272A33)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      hintText: 'Digite seu telefone',
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
                const SizedBox(height: 30),
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
                        Navigator.pushNamed(context, '/cadastro_efetuado'); // Navegar para a tela de "Feito"
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
                const SizedBox(height: 20),
                // Frase abaixo do botão centralizada com partes em negrito e cor diferente
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'Ao avançar, você concorda com todos os ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF737373),
                      fontFamily: 'MinhaFonte',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Termos do Aplicativo VIA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF272A33),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF737373),
                          fontFamily: 'MinhaFonte',
                        ),
                      ),
                    ],
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
