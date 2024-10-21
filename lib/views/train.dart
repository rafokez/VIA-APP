import 'package:flutter/material.dart';

class TrainPage extends StatelessWidget {
  const TrainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logo.png', // Caminho para a logo
              height: 40,
            ),
            const SizedBox(width: 10), // Espaço entre a logo e o texto
            const Text(
              'Trem',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF272A33),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Ação ao clicar no ícone de busca
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Ação ao clicar no ícone de notificações
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFE7DDBF),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Trem',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          _buildLineStatus(
            context,
            lineName: 'Lilás',
            isOperational: true,
            schedule: '05:00 - 23:00',
            departureLocation: 'Estação A',
          ),
          _buildLineStatus(
            context,
            lineName: 'Azul',
            isOperational: false,
            schedule: '04:30 - 00:00',
            departureLocation: 'Estação B',
          ),
          _buildLineStatus(
            context,
            lineName: 'Amarela',
            isOperational: true,
            schedule: '06:00 - 22:00',
            departureLocation: 'Estação C',
          ),
          const SizedBox(height: 16),
          const Text(
            'No momento, não há mais linhas disponíveis. Tente viajar de metrô!',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildLineStatus(
    BuildContext context, {
    required String lineName,
    required bool isOperational,
    required String schedule,
    required String departureLocation,
  }) {
    Color borderColor = isOperational ? _getLineColor(lineName) : Colors.grey;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lineName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Status: ${isOperational ? 'Funcionando' : 'Não Funcionando'}'),
            Text('Horário: $schedule'),
            Text('Local de Partida: $departureLocation'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para rastrear agora pode ser implementada aqui
              },
              child: const Text('Rastrear agora'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getLineColor(String lineName) {
    switch (lineName) {
      case 'Lilás':
        return Colors.purple;
      case 'Amarela':
        return Colors.yellow;
      case 'Azul':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
