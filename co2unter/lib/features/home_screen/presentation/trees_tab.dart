import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TreesTab extends StatefulWidget {
  const TreesTab({Key? key}) : super(key: key);

  @override
  _TreesTabState createState() => _TreesTabState();
}

class _TreesTabState extends State<TreesTab> {
  final TextEditingController _co2Controller = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  int _oldTrees = 0;
  int _mediumTrees = 0;
  int _saplings = 0;

  @override
  void initState() {
    super.initState();
    _co2Controller.addListener(_updateButtonState);
    _areaController.addListener(_updateButtonState);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.black, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                'Kalkulator',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCalculatorInputs(),
          const SizedBox(height: 16),
          _buildTreeDisplayField('tree_large', '100-letnie drzewa', _oldTrees),
          _buildTreeDisplayField('tree_mid', 'Średnie drzewa', _mediumTrees),
          _buildTreeDisplayField('tree_small', 'Małe sadzonki', _saplings),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _areInputsValid() ? _calculate : null,
            child: const Text('Przelicz'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorInputs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildInputField('Emisja CO₂', 'kg CO₂', _co2Controller),
          const SizedBox(height: 8),
          _buildInputField('Powierzchnia*', 'ha parku', _areaController),
          const SizedBox(height: 4),
          Text(
            '* Powierzchnia parku w hektarach potrzebna do zaabsorbowania podanej ilości CO₂.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
      String label, String suffix, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: Theme.of(context).textTheme.titleLarge),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: suffix,
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTreeDisplayField(
      String imageLabel, String treeType, int treeCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/$imageLabel.png',
          height: 120,
        ),
        SizedBox(width: 35),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(treeType, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: treeCount != 0
                  ? Text(
                      '${treeCount.toString()} drzew',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  : Text(
                      'Liczba drzew',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
            )
          ],
        ),
      ],
    );
  }

  bool _areInputsValid() {
    return _co2Controller.text.isNotEmpty &&
        _areaController.text.isNotEmpty &&
        int.parse(_co2Controller.text) > 0 &&
        double.parse(_areaController.text) > 0;
  }

  void _updateButtonState() {
    setState(() {});
  }

  void _calculate() {
    setState(() {
      int co2 = int.parse(_co2Controller.text);
      double area = double.parse(_areaController.text);

      // Simplified logic for tree absorption rates (kg CO2 per year):
      // Old trees: 20 kg/year
      // Medium trees: 10 kg/year
      // Saplings: 5 kg/year

      _oldTrees = (co2 * 0.4 / 20).ceil(); // 40% of absorption by old trees
      _mediumTrees =
          (co2 * 0.3 / 10).ceil(); // 30% of absorption by medium trees
      _saplings = (co2 * 0.3 / 5).ceil(); // 30% of absorption by saplings

      // Adjust numbers based on available area (assuming 1 old tree needs 100 m2, 1 medium tree needs 50 m2, 1 sapling needs 10 m2)
      double availableArea = area * 10000; // convert hectares to square meters
      int totalArea = _oldTrees * 100 + _mediumTrees * 50 + _saplings * 10;

      if (totalArea > availableArea) {
        double ratio = availableArea / totalArea;
        _oldTrees = (_oldTrees * ratio).floor();
        _mediumTrees = (_mediumTrees * ratio).floor();
        _saplings = (_saplings * ratio).floor();
      }
    });
  }

  @override
  void dispose() {
    _co2Controller.dispose();
    _areaController.dispose();
    super.dispose();
  }
}
