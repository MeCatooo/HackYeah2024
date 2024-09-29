// me_tab.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../user_profile/widgets/tree_image.dart';

class MeTab extends StatefulWidget {
  const MeTab({Key? key}) : super(key: key);

  @override
  State<MeTab> createState() => _MeTabState();
}

class _MeTabState extends State<MeTab> {

  double carbonFootprintPercentage  = 0;
  @override
  void initState() {
    super.initState();
    getState().then((x){
      setState(() {
        carbonFootprintPercentage = x;
      });
    });
  }

  Future<double> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getDouble('results');
    return data ?? 0;
  }


  @override
  Widget build(BuildContext context) {
    print(carbonFootprintPercentage);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Twój ślad węglowy to około:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/tree_large.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text('100-Letnie drzewa'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: 0 != 0
                          ? Text(
                              'dużo drzew',
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          : Text(
                              'Liczba drzew',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/tree_mid.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text('Średnie drzewa'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: 0 != 0
                          ? Text(
                              'dużo drzew',
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          : Text(
                              'Liczba drzew',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/tree_small.png'),
                      width: 50,
                      height: 50,
                    ),
                    Text('Małe drzewa'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: 0 != 0
                          ? Text(
                              'dużo drzew',
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          : Text(
                              'Liczba drzew',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                    )
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
