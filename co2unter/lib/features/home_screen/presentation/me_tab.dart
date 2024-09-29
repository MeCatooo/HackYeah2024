import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../survey/presentation/survey_screen.dart';
import '../../user_profile/widgets/tree_image.dart';

class MeTab extends StatefulWidget {
  const MeTab({Key? key}) : super(key: key);

  @override
  State<MeTab> createState() => _MeTabState();
}

class _MeTabState extends State<MeTab> {
  final ScrollController _scrollController = ScrollController();
  bool _isSecondImageVisible = false;
  double carbonFootprintPercentage = 0;
  double carbonKilograms = 0;
  final double largeTreeAbsorption = 22.0;
  final double mediumTreeAbsorption = 11.0;
  final double smallTreeAbsorption = 5.0;

  @override
  void initState() {
    super.initState();
    getState('results').then((x) {
      setState(() {
        carbonFootprintPercentage = x;
      });
    });

    getState('karbon').then((x) {
      setState(() {
        carbonKilograms = x;
      });
    });
  }

  Future<double> getState(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getDouble(name);
    return data ?? 0;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(carbonFootprintPercentage);

    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Twój ślad węglowy to około: \n${carbonKilograms.toString()} kg CO₂',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const SurveyScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.edit_note_outlined,
                      size: 48,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            const Center(
              child: TreeImage(
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                '${carbonFootprintPercentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: carbonFootprintPercentage <= 100
                      ? Theme.of(context).colorScheme.primary
                      : Colors.red,
                ),
              ),
            ),
            const Center(
              child: Text(
                'średniego śladu węglowego\nprzeciętnej osoby!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTreeColumn(
                    'assets/images/tree_large.png',
                    '100-Letnie drzewa',
                    calculateTreeCount(largeTreeAbsorption)),
                _buildTreeColumn('assets/images/tree_mid.png', 'Średnie drzewa',
                    calculateTreeCount(mediumTreeAbsorption)),
                _buildTreeColumn('assets/images/tree_small.png', 'Małe drzewa',
                    calculateTreeCount(smallTreeAbsorption)),
              ],
            )),
            const SizedBox(height: 10),
            Center(
              child: IconButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(Icons.keyboard_arrow_down, size: 48),
              ),
            ),
            const Image(
              image: AssetImage('assets/images/graphs.png'),
              width: double.infinity,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSecondImageVisible = true;
                });
              },
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(_isSecondImageVisible
                        ? 'assets/images/card2.png'
                        : 'assets/images/card.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (_isSecondImageVisible)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSecondImageVisible = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, color: Colors.black),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int calculateTreeCount(double absorption) {
    return (carbonKilograms / absorption).ceil();
  }

  // Helper method to build tree columns
  Widget _buildTreeColumn(String imagePath, String title, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(imagePath),
          height: 80,
        ),
        Text(title),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            count.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
      ],
    );
  }
}
