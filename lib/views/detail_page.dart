import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  final String address;
  final String transportMode;

  const DetailPage({
    super.key,
    required this.address,
    required this.transportMode,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String address;
  late String transportMode;
  LatLng? currentMetroLocation;
  List<LatLng> metroLocations = [];
  int currentLocationIndex = 0;
  Timer? timer;
  String? token; // Variável para armazenar o token de autenticação

  @override
  void initState() {
    super.initState();
    address = widget.address;
    transportMode = widget.transportMode;
    _loadToken(); // Carregar o token
    _startMetroLocationUpdate();

    // Atualizar as localizações periodicamente
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _fetchMetroLocations();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Carregar o token do SharedPreferences
  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('authToken'); // Obter o token armazenado
    });
  }

  Future<void> _startMetroLocationUpdate() async {
    try {
      final response = await http.post(
        Uri.parse('https://api-via.azurewebsites.net/Localization/start-atualization'),
        headers: {
          'accept': '*/*',
        },
        body: '',
      );

      if (response.statusCode == 200) {
        print('Atualização iniciada com sucesso.');
        _fetchMetroLocations();
      } else {
        print('Erro ao iniciar a atualização: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  Future<void> _stopMetroLocationUpdate() async {
    try {
      final response = await http.post(
        Uri.parse('https://api-via.azurewebsites.net/Localization/stop-atualization'),
        headers: {
          'accept': '*/*',
        },
        body: '',
      );

      if (response.statusCode == 200) {
        print('Atualização parada com sucesso.');
        Navigator.pushNamed(context, '/tela_finalizar_trajeto');
      } else {
        print('Erro ao parar a atualização: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  Future<void> _fetchMetroLocations() async {
    try {
      final response = await http.get(
        Uri.parse('https://api-via.azurewebsites.net/Localization/localizacoes'),
        headers: {
          'accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> locations = jsonDecode(response.body);
        print('Localizações recebidas: $locations');

        setState(() {
          metroLocations.clear();
          for (var location in locations) {
            final latitude = location['latitude'];
            final longitude = location['longitude'];
            if (latitude != null && longitude != null) {
              metroLocations.add(LatLng(latitude, longitude));
            }
          }

          if (metroLocations.isNotEmpty) {
            currentMetroLocation = metroLocations[currentLocationIndex % metroLocations.length];
            currentLocationIndex++;
          }
        });
      } else {
        print('Erro ao carregar localizações: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  Future<void> _finalizarViagem() async {
    // Verificar se o token foi carregado
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado.')),
      );
      return;
    }

    // Exemplo de dados que você pode enviar na finalização
    final viagemData = {
      'dataHora': DateTime.now().toIso8601String(), // Data e hora atual da finalização
      'localPartida': 'Estação Jabaquara', // Pode ser dinâmico conforme a estação
      'localDestino': address, // O destino fornecido
      'meioTransporte': transportMode, // Modo de transporte selecionado
    };

    try {
      final response = await http.post(
        Uri.parse('https://api-via.azurewebsites.net/Localization/finalizar-viagem'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token', // Envia o token de autenticação
          'Content-Type': 'application/json',
        },
        body: jsonEncode(viagemData), // Envia os dados da viagem
      );

      if (response.statusCode == 200) {
        print('Viagem finalizada com sucesso.');
        Navigator.pushReplacementNamed(context, '/tela_finalizar_trajeto');
      } else {
        print('Erro ao finalizar a viagem: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao finalizar a viagem: ${response.body}')),
        );
      }
    } catch (e) {
      print('Erro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            children: [
              Image.asset(
                'lib/assets/logo.png',
                height: 40,
              ),
              const SizedBox(height: 8),
              const Text(
                'Iniciando seu trajeto...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF272A33),
        ),
      ),
      backgroundColor: const Color(0xFFE7DDBF),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: const Color(0xFF272A33),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Linha selecionada: Linha Azul',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.train, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Linha Azul - 12h00 / 20h00 - Bairro Santo Amaro',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Localização: Estação Jabaquara',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-23.5505, -46.6333), // Posição inicial do mapa
                zoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                if (currentMetroLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: currentMetroLocation!,
                        builder: (context) => SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset('lib/assets/train-icon.png'),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _finalizarViagem(); // Função para finalizar a viagem
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.check),
        tooltip: 'Finalizar trajeto',
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF272A33),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.train,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Ande até a estação de trem/metrô mais próxima',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: Colors.white70, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Estação Jabaquara, Avenida Paulista 10309',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.location_on, color: Colors.white70, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      address,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
