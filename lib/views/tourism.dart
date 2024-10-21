import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_page.dart'; // Certifique-se de criar este arquivo
import 'tela_notificacao.dart'; // Certifique-se de criar este arquivo

class TourismPage extends StatefulWidget {
  const TourismPage({super.key});

  @override
  _TourismPageState createState() => _TourismPageState();
}

class _TourismPageState extends State<TourismPage> {
  LatLng _center = LatLng(-23.587416, -46.657634); // Coordenadas de São Paulo
  List<Marker> _markers = [];

  // Pontos turísticos pré-definidos
  final Map<String, Map<String, dynamic>> _touristSpots = {
    "Beco do Robin": {
      "latitude": -23.645441,
      "longitude": -46.641206,
      "description": "O Beco do Robin, ou Viela Beco do Robin, é um logradouro localizado na vizinhança Parque Santo Antônio, no bairro administrativo de Torres Tibagy, em Guarulhos, Brasil. A travessa ficou conhecida como uma galeria a céu aberto, recebendo esse nome em homenagem ao personagem fictício homônimo da DC Comics.",
      "imageUrl": "https://f.i.uol.com.br/fotografia/2022/04/18/1650301986625d9c220749a_1650301986_3x2_md.jpg",
    },
    "Centro Cultural SP": {
      "latitude": -23.570797527297525,
      "longitude": -46.640059732450425,
      "description": "Conheça os espaços do CCSP, um centro cultural multidisciplinar com jardins, bibliotecas, salas de espetáculo, expositivos e espaços educativos. Saiba como acessar, agendar e participar das atividades e eventos oferecidos pelo CCSP.",
      "imageUrl": "https://guiaviajarmelhor.com.br/wp-content/uploads/2019/04/passeios-culturais-em-S%C3%A3o-Paulo-1.jpg",
      "events": [
        {
          "title": "Yayá Massemba",
          "date": "26/11 Terça, às 19h",
          "description": "A banda Yayá Massemba se prepara para realizar a turnê de lançamento do seu primeiro EP, “De Umbigo a Umbigo”, reunindo …",
          "imageUrl": "https://centrocultural.sp.gov.br/wp-content/uploads/2024/10/20240906162210_IMG_9583ps-1160x653.jpg",
        },
        {
          "title": "Projeto Releituras – Luedji Luna canta Sade",
          "date": "27/11 e 28/11 Quarta e quinta, às 19h",
          "description": "Dona de uma das vozes brasileiras mais potentes da atualidade, Luedji Luna apresenta a turnê “Bom mesmo …",
          "imageUrl": "https://centrocultural.sp.gov.br/wp-content/uploads/2024/10/6f306fd1-3779-4ff1-839b-fb92d4e2aaba-1160x653.jpg",
        },
        {
          "title": "Encontro de Slams e Saraus – Sarau no Kintal",
          "date": "6/11 Quarta, às 20h",
          "description": "O Sarau no Kintal é um sarau que ocorre há onze anos mensalmente em São Paulo, na Brasilândia …",
          "imageUrl": "https://centrocultural.sp.gov.br/wp-content/uploads/2024/10/Foto-2-1160x653.jpg",
        },
      ],
    },
  };

  Future<void> _searchTouristSpot(String query) async {
    // Limpa os marcadores antes de adicionar novos
    _markers.clear();
    bool found = false;

    if (_touristSpots.containsKey(query)) {
      final spot = _touristSpots[query]!;

      // Adicionar marcador
      _markers.add(
        Marker(
          point: LatLng(spot["latitude"], spot["longitude"]),
          builder: (context) => Icon(Icons.location_pin, color: Colors.red, size: 40),
        ),
      );

      _center = LatLng(spot["latitude"], spot["longitude"]); // Atualiza a posição central do mapa

      // Exibe o diálogo com as informações do ponto turístico
      _showTouristSpotDialog(query, spot["description"], spot["imageUrl"], spot["events"]);

      found = true;
    }

    if (!found) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ponto turístico não encontrado!')),
      );
    }

    setState(() {}); // Atualiza o estado para renderizar o mapa novamente
  }

  void _showTouristSpotDialog(String title, String description, String imageUrl, List<dynamic>? events) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
              SizedBox(height: 8),
              Text(description),
              SizedBox(height: 16),
              if (events != null && events.isNotEmpty) ...[
                Text("Eventos Programados:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...events.map((event) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event["title"], style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(event["date"]),
                      Text(event["description"]),
                      Image.network(event["imageUrl"]),
                    ],
                  ),
                )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
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
          FlutterMap(
            options: MapOptions(
              center: _center,
              zoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar ponto turístico...',
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: appBarColor,
              ),
              style: const TextStyle(color: Colors.white),
              onSubmitted: (String value) {
                _searchTouristSpot(value); // Chama a função de busca ao submeter
              },
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
            _buildBottomNavBarItem(Icons.home, 'Home', iconColor, () {
              Navigator.pushNamed(context, '/home');
            }),
            _buildBottomNavBarItem(Icons.map, 'Turismo', const Color(0xFFE7DDBF), () {
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
