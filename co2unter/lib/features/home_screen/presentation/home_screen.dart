// lib/features/home_screen/presentation/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../intro/presentation/intro_screen.dart';
import '../../survey/presentation/survey_screen.dart';
import '../widgets/custom_tab_bar.dart';
import 'me_tab.dart';
import 'city_tab.dart';
import 'trees_tab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _tabScreens = <Widget>[
    MeTab(),
    CityTab(),
    TreesTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: _tabScreens.elementAt(_selectedIndex),
            ),
            CustomTabBar(
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Debug Options', style: theme.textTheme.titleLarge),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SurveyScreen()));
                      },
                      child: const Text('Ankieta'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const IntroScreen()));
                      },
                      child: const Text('Intro'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: theme.primaryColor,
        child: Icon(Icons.bug_report, color: theme.scaffoldBackgroundColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
