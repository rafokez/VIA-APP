import 'package:flutter/material.dart';
import 'detail_page.dart';
// Certifique-se de importar a tela de configurações

class TelaViagemMetro extends StatelessWidget {
  const TelaViagemMetro({super.key});

  @override
  Widget build(BuildContext context) {
    const appBarColor = Color(0xFF272A33); // Cor da Navbar de cima
    const bottomNavBarColor = Color(0xFF272A33); // Cor de fundo da BottomNavigationBar
    const iconColor = Color(0xFFE4E4E4); // Cor dos ícones e texto dos itens da BottomNavigationBar

    return Scaffold(
      backgroundColor: const Color(0xFFE7DDBF), // Cor de fundo bege
      appBar: AppBar(
        backgroundColor: appBarColor, // Cor da Navbar
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
              'Viagem de Metrô',
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
      bottomNavigationBar: BottomAppBar(
        color: bottomNavBarColor, // Cor de fundo da BottomNavigationBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavBarItem(Icons.directions_subway, 'Metrô', const Color(0xFFE7DDBF), () {
              Navigator.pushNamed(context, '/viagem_metro'); // Navega para a tela ViagemMetro
            }),
            _buildBottomNavBarItem(Icons.train, 'Trem', iconColor, () {
              Navigator.pushNamed(context, '/viagem_trem'); // Navega para a tela ViagemTrem
            }),
            _buildBottomNavBarItem(Icons.home, 'Home', iconColor, () {
              Navigator.pushNamed(context, '/home'); // Navega para a tela Home
            }),
            _buildBottomNavBarItem(Icons.map, 'Turismo', iconColor, () {
              Navigator.pushNamed(context, '/tourism'); // Navega para a tela Turismo
            }),
            _buildBottomNavBarItem(Icons.settings, 'Config.', iconColor, () {
              Navigator.pushNamed(context, '/configuracao'); // Navega para a tela Configuracao
            }),
          ],
        ),
      ),
      body: SingleChildScrollView( // Adiciona a rolagem
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400), // Limita a largura do TextField
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Insira uma linha de preferência',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Reduz a borda arredondada
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.search, color: Colors.grey), // Adiciona o ícone de pesquisa
                ),
              ),
            ),
            const SizedBox(height: 60),
            metroLineCard('Linha Azul', '12h / 20h - Estação Jabaquara', 'Ativa', const Color.fromARGB(255, 39, 41, 176), context),
            const SizedBox(height: 40),
            metroLineCard('Linha Vermelha', '12h / 20h - Bairro Nobre', 'Inativa', Colors.red, context),
            const SizedBox(height: 60),
            Center(
              child: Image.asset(
                'lib/assets/image/imagemmetro.png', // Caminho para a imagem centralizada
                height: 200,
              ),
            ),
            const SizedBox(height: 10), // Espaço adicional para garantir que o texto não fique muito colado à imagem
            const Center(
              child: Text(
                'Não achou o que desejava?\nTente viajar de trem!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBarItem(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  Widget metroLineCard(String lineName, String schedule, String status, Color color, BuildContext context) {
  return MouseRegion(
    cursor: SystemMouseCursors.click, // Adiciona cursor de clique
    child: GestureDetector(
      onTap: () {
        // Ação ao clicar no cartão (se necessário)
      },
      child: Stack(
        clipBehavior: Clip.none, // Permite que o conteúdo do Stack ultrapasse os limites do cartão
        children: [
          Container(
            margin: const EdgeInsets.only(right: 0), // Espaço para o botão sair
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Alterar a direção da sombra
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                '$lineName - $schedule',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Status: $status'),
            ),
          ),
          Positioned(
  right: 0, // Alinha o botão à direita
  bottom: -10, // Ajusta a posição para sobrepor o cartão
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color, // Define a cor de fundo do botão
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Ajusta o padding para o botão
    ),
    onPressed: () {
      // Exemplo de dados que você pode passar
      String address = 'Endereço Exemplo'; // Substitua pelo endereço real
      String transportMode = 'Metrô'; // Pode ser 'Metrô', 'Trem', etc.

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(address: address, transportMode: transportMode),
        ),
      );
    },
    child: const Text(
      'Rastrear agora',
      style: TextStyle(color: Colors.white), // Define a cor do texto do botão como branco
    ),
  ),
),
        ],
      ),
    ),
  );
}
}