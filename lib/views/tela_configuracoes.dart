import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/views/home.dart';
import 'package:google_maps_in_flutter/views/tela_feedbacks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaConfiguracoes extends StatelessWidget {
  const TelaConfiguracoes({super.key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove o token de autenticação ou outro dado do usuário armazenado
    Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false); // Redireciona para a tela inicial após deslogar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272A33),
        automaticallyImplyLeading: false, // Remove a seta de voltar
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
        elevation: 0, // Remove a sombra da AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 26),
              const Text(
                'Configurações',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF272A33),
                  fontFamily: 'MinhaFonte',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFF272A33),
              ),
              const SizedBox(height: 36),
              // Botão "Configurações de segurança"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7DDBF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xFF272A33), width: 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/configuracao_seguranca');
                  },
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.lock, color: Color(0xFF272A33)),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Configurações de segurança',
                          style: TextStyle(
                            color: Color(0xFF272A33),
                            fontSize: 16,
                            fontFamily: 'MinhaFonte',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botão "Seu perfil e informações básicas"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7DDBF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xFF272A33), width: 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/perfil');
                  },
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.person, color: Color(0xFF272A33)),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Seu perfil e informações básicas',
                          style: TextStyle(
                            color: Color(0xFF272A33),
                            fontSize: 16,
                            fontFamily: 'MinhaFonte',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botão "Seus feedbacks"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7DDBF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xFF272A33), width: 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaFeedbacks()),
                    );
                  },
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.feedback, color: Color(0xFF272A33)),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Seus feedbacks',
                          style: TextStyle(
                            color: Color(0xFF272A33),
                            fontSize: 16,
                            fontFamily: 'MinhaFonte',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botão "Histórico de viagens"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE7DDBF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Color(0xFF272A33), width: 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/historico_viagens');
                  },
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.history, color: Color(0xFF272A33)),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Histórico de viagens',
                          style: TextStyle(
                            color: Color(0xFF272A33),
                            fontSize: 16,
                            fontFamily: 'MinhaFonte',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Botão "Deslogar"
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE7DDBF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFF272A33), width: 1),
                      ),
                    ),
                    onPressed: () {
                      _logout(context); // Chama a função de logout ao clicar no botão
                    },
                    child: const Text(
                      'Deslogar',
                      style: TextStyle(
                        color: Color(0xFF272A33),
                        fontSize: 16,
                        fontFamily: 'MinhaFonte',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Imagem centralizada
              Center(
                child: Image.asset(
                  'lib/assets/image/imagemconfiguracao.png', // Substitua pelo caminho da sua imagem
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Container(
                  width: 100,
                  height: 1,
                  color: const Color(0xFF272A33),
                ),
              ),
              const SizedBox(height: 35),
              // Botão "Retornar"
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF272A33),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text(
                    'Retornar',
                    style: TextStyle(
                      color: Color(0xFFE7DDBF),
                      fontSize: 18,
                      fontFamily: 'MinhaFonte',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Frase de direitos autorais centralizada
              const Center(
                child: Text(
                  '© Equipe Legacy - Todos os direitos reservados VIA 2024',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF737373),
                    fontFamily: 'MinhaFonte',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE7DDBF), // Cor de fundo igual ao app
    );
  }
}
