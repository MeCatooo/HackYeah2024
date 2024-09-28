import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../survey/presentation/full_survey_screen.dart';
import '../../survey/presentation/lite_survey_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kraków Carbon Footprint')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FullSurveyScreen())),
              child: const Text('Pełna ankieta'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LiteSurveyScreen())),
              child: const Text('Ankieta tygodniowa'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CityDataScreen())),
              child: const Text('Dane miasta'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const UserProfileScreen())),
              child: const Text('Profil użytkownika'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CarbonFootprintScreen())),
              child: const Text('Twój ślad węglowy'),
            ),
          ],
        ),
      ),
    );
  }
}
