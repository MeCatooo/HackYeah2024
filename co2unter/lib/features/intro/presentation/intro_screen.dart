import 'package:co2unter/features/survey/presentation/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/wide_button.dart';
import '../../home_screen/presentation/home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroPage> _pages = [
    IntroPage(
      title: 'CO₂ w Krakowie',
      text:
          'Monitoruj, ile CO2 generujesz na co dzień i zobacz, jak zieleń miejska w Krakowie pomaga to neutralizować.',
      imagePath: 'assets/images/intro1.png',
    ),
    IntroPage(
      title: 'CO₂ w Krakowie',
      text:
          'Z nami łatwo zrozumiesz, jak Twoje wybory wpływają na środowisko i jak możesz je poprawić.',
      imagePath: 'assets/images/intro2.png',
    ),
    IntroPage(
      title: 'CO₂ w Krakowie',
      text:
          'Odpowiedz na kilka prostych pytań dotyczących Twojego stylu życia i zobacz, jak Twoje działania wpływają na środowisko.',
      imagePath: 'assets/images/intro4.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildPageContent(_pages[index], theme);
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomButton(
                  text: _currentPage == _pages.length - 1
                      ? 'Rozpocznij ankietę'
                      : 'Dalej',
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _finishIntro();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(IntroPage page, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            page.title,
            style: theme.textTheme.displayMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            page.text,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 40),
          Image.asset(
            page.imagePath,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ],
      ),
    );
  }

  void _finishIntro() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SurveyScreen()),
    );
  }
}

class IntroPage {
  final String title;
  final String text;
  final String imagePath;

  IntroPage({required this.title, required this.text, required this.imagePath});
}
