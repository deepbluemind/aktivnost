import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'aktivnost_screen.dart';
import 'aktivnost_detalji_screen.dart';
import 'city_picker_screen.dart';

void main() {
  runApp(const AktivnostApp());
}

class AktivnostApp extends StatelessWidget {
  const AktivnostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        AktivnostScreen.routeName: (context) => const AktivnostScreen(),
        AktivnostDetaljiScreen.routeName: (context) => const AktivnostDetaljiScreen(),
        CityPickerScreen.routeName: (context) => CityPickerScreen(),
      },
    );
  }
}