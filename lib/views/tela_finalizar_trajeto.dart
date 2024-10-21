import 'package:flutter/material.dart';
import 'tela_cadastro_feedback.dart';
import 'tela_historico_viagens.dart'; // Certifique-se de que esta importação esteja correta
import 'package:http/http.dart' as http;

class TelaFinalizarTrajeto extends StatelessWidget {
  const TelaFinalizarTrajeto({Key? key}) : super(key: key);

  Future<void> pararAtualizacao(BuildContext context) async {
    // URL da API para parar a atualização
    final url = 'https://api-via.azurewebsites.net/Localization/stop-atualization';

    try {
      // Enviar a solicitação POST para parar a atualização
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      // Verifica se a solicitação foi bem-sucedida
      if (response.statusCode == 200) {
        // Se bem-sucedido, navega para a tela de histórico de viagens
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TelaHistoricoViagens()),
        );

        // Exibe a mensagem no console
        print('Atualização parada com sucesso!');
      } else {
        // Trate o erro de acordo com sua lógica
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao parar a atualização')),
        );
      }
    } catch (e) {
      // Trate erros de rede ou exceções
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro de conexão')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF272A33),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            color: const Color(0xFF272A33),
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/logo.png', // Altere para o caminho correto do logo
                  height: 50,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Trajeto Finalizado',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 24, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF272A33),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Linha selecionada: Linha Lilás',
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Linha Azul - 12h00 / 20h00 - Jabaquara',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Localização: Jabaquara, São Paulo',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 300, // Altura ajustável conforme necessário
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'lib/assets/image/imagemcadastroefetuado.png', // Substitua pela imagem correta
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF272A33),
              borderRadius: BorderRadius.circular(12), // Borda arredondada
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Você chegou ao seu destino!',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => pararAtualizacao(context), // Chama a função para parar a atualização
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'Finalizar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Não esqueça de avaliar nosso aplicativo!',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaCadastroFeedback()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Colors.white, // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 3),
                  ),
                  child: const Text(
                    'Enviar feedback',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
