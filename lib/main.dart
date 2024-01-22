import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/screens/single_player_screen.dart';
import 'screens/tic_tac_toe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Reset scores when the app starts
  await resetScores();

  runApp(const MyApp());
}

Future<void> resetScores() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('playerXWins', 0);
  prefs.setInt('playerOWins', 0);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      //  home: const Home(),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        'tic_tac_toe_screen': (context) => const TicTacToe(),
        'single_player': (context) => const TicTacToeSinglePlayer()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
