// home.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'detail_page.dart'; // Certifique-se de criar este arquivo
import 'tela_notificacao.dart'; // Certifique-se de criar este arquivo

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  // Coordenadas de São Paulo
  final LatLng _center = const LatLng(-23.550520, -46.633308);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
    const appBarColor = Color(0xFF272A33);
    const bottomNavBarColor = Color(0xFF272A33);
    const iconColor = Color(0xFFE4E4E4);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/logo.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaNotificacao()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: bottomNavBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavBarItem(Icons.directions_subway, 'Metrô', iconColor, () {
              Navigator.pushNamed(context, '/viagem_metro');
            }),
            _buildBottomNavBarItem(Icons.train, 'Trem', iconColor, () {
              Navigator.pushNamed(context, '/viagem_trem');
            }),
            _buildBottomNavBarItem(Icons.home, 'Home', const Color(0xFFE7DDBF), () {
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
    );
  }
}