import 'package:flutter/material.dart';

class TelaNotificacao extends StatelessWidget {
  const TelaNotificacao({super.key});

 Widget _buildBottomNavBarItem(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bottomNavBarColor = Color(0xFF272A33); // Cor de fundo da BottomNavigationBar
    const iconColor = Color(0xFFE4E4E4); // Cor dos ícones e texto dos itens da BottomNavigationBar
    return Scaffold(
      backgroundColor: const Color(0xFFE7DDBF), // Cor de fundo bege
      appBar: AppBar(
        backgroundColor: const Color(0xFF272A33), // Cor da Navbar
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logo.png', // Substitua pelo caminho correto
              height: 40,
            ),
            const SizedBox(width: 50),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: bottomNavBarColor, // Cor de fundo da BottomNavigationBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavBarItem(Icons.directions_subway, 'Metrô', iconColor, () {
              Navigator.pushNamed(context, '/viagem_metro');
            }),
            _buildBottomNavBarItem(Icons.train, 'Trem', iconColor, () {
              Navigator.pushNamed(context, '/viagem_trem');
            }),
            _buildBottomNavBarItem(Icons.home, 'Home', iconColor, () {
              Navigator.pushNamed(context, '/home');
            }),
            _buildBottomNavBarItem(Icons.map, 'Turismo', iconColor, () {
              Navigator.pushNamed(context, '/tourism');
            }),
            _buildBottomNavBarItem(Icons.settings, 'Config.', iconColor, () {
              Navigator.pushNamed(context, '/configuracao');
            }),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Alertas de hoje',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            alertCard('Estação Jabaquara:', 'O trem da linha amarela está com defeito.', context),
            const SizedBox(height: 10),
            alertCard('Estação de Metrô da Capital de SP:', 'Hoje, o metrô da linha lilás não irá circular por motivos técnicos.', context),
            const Spacer(),
            const Center(
              child: Text(
                'Mais alertas aparecerão conforme o uso!',
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

  Widget alertCard(String title, String description, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF272A33), width: 2),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.notifications_active, color: Colors.red),
      ),
    );
  }
}