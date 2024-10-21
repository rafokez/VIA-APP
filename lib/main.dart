import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/views/detail_page.dart';
import 'package:google_maps_in_flutter/views/tela_cadastro_feedback.dart';
import 'package:google_maps_in_flutter/views/tela_finalizar_trajeto.dart';
import 'views/tela_historico_viagens.dart';
import 'views/tela_perfil.dart';
import 'views/tela_configuracoes_seguranca.dart';
import 'views/tela_alterar_senha.dart';
import 'views/tela_configuracoes.dart';
import 'views/tela_cadastro_efetuado.dart';
import 'views/tela_cadastro_usuario_1.dart';
import 'views/tela_cadastro_usuario_2.dart';
import 'views/tela_feito.dart';
import 'views/tela_conseguimos.dart';
import 'views/tela_esqueci_senha_2.dart';
import 'views/tela_esqueci_senha_1.dart';
import 'views/tela_bem_vindo.dart';
import 'views/tela_login.dart';
import 'views/tela_viagem_metro.dart';
import 'views/tela_viagem_trem.dart';
import 'views/tela_notificacao.dart';
import 'views/home.dart'; // Aqui é o arquivo correto de HomePage
import 'views/tourism.dart';
import 'views/settings.dart';
import 'views/tela_feedback_efetuado.dart';
import 'views/tela_feedbacks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App VIA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFE7DDBF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF272A33),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF272A33),
          selectedItemColor: Color(0xFFE7DDBF),
          unselectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
      initialRoute: '/', // Define a rota inicial
      routes: {
        '/home': (context) => const HomePage(),
        '/notificacao': (context) => const TelaNotificacao(),
        '/': (context) => const TelaBemVindo(), // Tela inicial ao abrir o app
        '/historico_viagens': (context) => const TelaHistoricoViagens(),
        '/perfil': (context) => const TelaPerfil(),
        '/configuracao_seguranca': (context) => const TelaConfiguracoesSeguranca(),
        '/configuracao': (context) => const TelaConfiguracoes(),
        '/alterar_senha': (context) => const TelaAlterarSenha(),
        '/cadastro_efetuado': (context) => const TelaCadastroEfetuado(),
        '/cadastro_usuario_1': (context) => const TelaCadastroUsuario1(),
        '/cadastro_usuario_2': (context) => const TelaCadastroUsuario2(),
        '/feito': (context) => const TelaFeito(),
        '/conseguimos': (context) => const TelaConseguimos(),
        '/esqueci_senha_2': (context) => const TelaEsqueciSenha2(),
        '/esqueci_senha_1': (context) => const TelaEsqueciSenha1(),
        '/login': (context) => const TelaLogin(),
        '/viagem_metro': (context) => const TelaViagemMetro(),
        '/viagem_trem': (context) => const TelaViagemTrem(),
        '/tourism': (context) => const TourismPage(),
        '/settings': (context) => const SettingsPage(),
        '/tela_finalizar_trajeto': (context) => const TelaFinalizarTrajeto(),
        '/tela_cadastro_feedback': (context) => const TelaCadastroFeedback(),
        '/tela_feedback_efetuado': (context) => const TelaFeedbackEfetuado(),
        '/tela_feedbacks': (context) => const TelaFeedbacks(),
      },
    );
  }
}