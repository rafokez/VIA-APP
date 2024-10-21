import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
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
              'Configurações',
              style: TextStyle(color: Color(0xFF272A33), fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF272A33),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF272A33)),
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
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Segurança'),
                Tab(text: 'Perfil'),
                Tab(text: 'Histórico de Viagens'),
                Tab(text: 'Feedbacks'),
              ],
              indicatorColor: Color(0xFF272A33), // Cor do indicador da TabBar
              labelColor: Color(0xFF272A33), // Cor dos textos das abas selecionadas
              unselectedLabelColor: Color(0xFF272A33), // Cor dos textos das abas não selecionadas
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildSecuritySettings(),
                  _buildProfileInfo(),
                  _buildTravelHistory(),
                  _buildFeedbackHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Configurações de Segurança',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF272A33)),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Alterar Senha',
              fillColor: Colors.grey[800],
              filled: true,
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Alterar Email',
              fillColor: Colors.grey[800],
              filled: true,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Informações Pessoais',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF272A33)),
          ),
          const SizedBox(height: 8),
          const Text('CPF: 123.456.789-00', style: TextStyle(color: Color(0xFF272A33))),
          const Text('Endereço: Rua Exemplo, 123', style: TextStyle(color: Color(0xFF272A33))),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informações do Perfil',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF272A33)),
          ),
          SizedBox(height: 16),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://www.example.com/profile.jpg'), // Placeholder image
          ),
          SizedBox(height: 16),
          Text('Nome: João da Silva', style: TextStyle(color: Color(0xFF272A33))),
          Text('Telefone: (11) 98765-4321', style: TextStyle(color: Color(0xFF272A33))),
          Text('Email: joao@example.com', style: TextStyle(color: Color(0xFF272A33))),
        ],
      ),
    );
  }

  Widget _buildTravelHistory() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Text(
            'Histórico de Viagens',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF272A33)),
          ),
          const SizedBox(height: 16),
          _buildTravelRecord('12/08/2024', '10:00', '30 minutos'),
          _buildTravelRecord('11/08/2024', '14:30', '45 minutos'),
        ],
      ),
    );
  }

  Widget _buildTravelRecord(String date, String time, String duration) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data: $date', style: const TextStyle(color: Colors.white)),
            Text('Hora: $time', style: const TextStyle(color: Colors.white)),
            Text('Duração: $duration', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackHistory() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Text(
            'Histórico de Feedbacks',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF272A33)),
          ),
          const SizedBox(height: 16),
          _buildFeedbackRecord('12/08/2024', 'Ótima viagem, tudo ocorreu conforme esperado.'),
          _buildFeedbackRecord('11/08/2024', 'O trem estava atrasado e o ar condicionado estava quebrado.'),
        ],
      ),
    );
  }

  Widget _buildFeedbackRecord(String date, String feedback) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data: $date', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Feedback: $feedback', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}