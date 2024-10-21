import 'package:flutter/material.dart';

class TelaHistoricoViagens extends StatefulWidget {
  const TelaHistoricoViagens({super.key});

  @override
  _TelaHistoricoViagensState createState() => _TelaHistoricoViagensState();
}

class _TelaHistoricoViagensState extends State<TelaHistoricoViagens> {
  // Lista de viagens pré-definidas
  final List<Map<String, String>> viagens = [
    {'linha': 'Linha Azul', 'localPartida': 'Jabaquara', 'data': '21/10'},
    {'linha': 'Linha Azul', 'localPartida': 'Jabaquara', 'data': '21/10'},
    {'linha': 'Linha Azul', 'localPartida': 'Jabaquara', 'data': '21/10'},
    {'linha': 'Linha Azul', 'localPartida': 'Jabaquara', 'data': '21/10'},
    {'linha': 'Linha Azul', 'localPartida': 'Jabaquara', 'data': '21/10'},
    {'linha': 'Linha Azul', 'localPartida': 'Jabaquara', 'data': '21/10'},
    {'linha': 'Linha Azul', 'localPartida': 'Jabaquara', 'data': '21/10'},
    {'linha': 'Linha Azul', 'localPartida': 'Jabaquara', 'data': '21/10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272A33),
        automaticallyImplyLeading: false,
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 26),
              const Text(
                'Histórico de viagens',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF272A33),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFF272A33),
              ),
              const SizedBox(height: 36),
              if (viagens.isEmpty)
                const Text('Nenhuma viagem registrada.')
              else
                ...viagens.map((viagem) {
                  return Column(
                    children: [
                      _buildTravelButton(viagem), // Exibe os detalhes da viagem
                      const SizedBox(height: 16), // Espaço entre as viagens
                    ],
                  );
                }).toList(),
              const SizedBox(height: 30),
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
                    Navigator.pushNamed(context, '/configuracao');
                  },
                  child: const Text(
                    'Retornar',
                    style: TextStyle(
                      color: Color(0xFFE7DDBF),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  '© Equipe Legacy - Todos os direitos reservados VIA 2024',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF737373),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE7DDBF),
    );
  }

  Widget _buildTravelButton(Map<String, String> viagem) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE7DDBF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color.fromARGB(255, 0, 64, 255), width: 1),
          ),
        ),
        onPressed: () {
          // Lógica para visualizar os detalhes da viagem, se necessário
        },
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.directions_bus, color: Color(0xFF272A33)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Linha: ${viagem['linha']}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 14, 49, 153),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Partida: ${viagem['localPartida']}',
                    style: const TextStyle(
                      color: Color(0xFF272A33),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Data: ${viagem['data']}',
                    style: const TextStyle(
                      color: Color(0xFF272A33),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
