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
  final TextEditingController _oldTreesController = TextEditingController();
  final TextEditingController _mediumTreesController = TextEditingController();
  final TextEditingController _saplingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Kalkulator',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          _buildInputField('Emisja CO₂', 'kg CO₂', _co2Controller),
          _buildInputField('Powierzchnia*', 'ha parku', _areaController),
          const SizedBox(height: 8),
          Text(
            '* Powierzchnia parku w hektarach potrzebna do zaabsorbowania podanej ilości CO₂.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          _buildTreeInputField('100-letnie drzewa', _oldTreesController),
          _buildTreeInputField('Średnie drzewa', _mediumTreesController),
          _buildTreeInputField('Małe sadzonki', _saplingController),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _calculate,
            child: const Text('Przelicz'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
      String label, String suffix, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _buildTreeInputField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Image.asset(
            'assets/images/${label.toLowerCase().replaceAll(' ', '_')}.png',
            height: 50,
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Liczba drzew',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _calculate() {
    // Implement calculation logic here
    // This is where you would update the state with calculated values
    // For now, we'll just print the values
    print('CO2: ${_co2Controller.text}');
    print('Area: ${_areaController.text}');
    print('100-year-old trees: ${_oldTreesController.text}');
    print('Medium trees: ${_mediumTreesController.text}');
    print('Saplings: ${_saplingController.text}');
  }

  @override
  void dispose() {
    _co2Controller.dispose();
    _areaController.dispose();
    _oldTreesController.dispose();
    _mediumTreesController.dispose();
    _saplingController.dispose();
    super.dispose();
  }
}
