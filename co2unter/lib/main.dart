import 'package:co2unter/common/theme.dart';
import 'package:co2unter/features/home_screen/presentation/home_screen.dart';
import 'package:co2unter/features/intro/presentation/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool introShown = prefs.getBool('intro_shown') ?? false;

  runApp(
    ProviderScope(
      child: MyApp(introShown: introShown),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool introShown;

  const MyApp({Key? key, required this.introShown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CO₂ w Krakowie',
      theme: AppTheme.themeData,
      home: introShown ? const HomeScreen() : const IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
