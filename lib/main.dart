import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/screens/home_screen.dart';

void main() => runApp(const ProviderScope(child: App()));

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Taskly',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF335EF9),
            secondary: Color(0xFFD9D9D9),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
            headlineSmall: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Color(0xFF676767),
            ),
            titleSmall: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Color(0xFF6F6F6F),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}
