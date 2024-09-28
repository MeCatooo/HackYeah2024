import 'package:flutter/material.dart';
import '../widgets/expandable_card.dart';

class CityTab extends StatefulWidget {
  const CityTab({Key? key}) : super(key: key);

  @override
  _CityTabState createState() => _CityTabState();
}

class _CityTabState extends State<CityTab> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (expandedIndex == null || expandedIndex == 0)
          _buildExpandableCard(
            'Transport',
            'assets/images/city1.png',
            'Środek transportu',
            'gramy CO2/km',
            transportData,
            0,
          ),
        if (expandedIndex == null || expandedIndex == 1)
          _buildExpandableCard(
            'Usługi',
            'assets/images/city2.png',
            'Usługa',
            'kilogramy CO2/dzień',
            servicesData,
            1,
          ),
        if (expandedIndex == null || expandedIndex == 2)
          _buildExpandableCard(
            'Wydarzenia',
            'assets/images/city3.png',
            'Wydarzenie',
            'ton CO2',
            eventsData,
            2,
          ),
      ],
    );
  }

  Widget _buildExpandableCard(
      String title,
      String imageAsset,
      String columnName,
      String unitName,
      List<Map<String, dynamic>> data,
      int index) {
    return ExpandableCard(
      title: title,
      imageAsset: imageAsset,
      columnName: columnName,
      unitName: unitName,
      data: data,
      onExpand: (isExpanded) {
        setState(() {
          expandedIndex = isExpanded ? index : null;
        });
      },
    );
  }
}

// Sample data
final transportData = [
  {'name': 'Samochód spalinowy', 'value': '150-300'},
  {'name': 'Samochód elektryczny', 'value': '50-100'},
  // Add more data
];

final servicesData = [
  {'name': 'Restauracja Pod Wawelem', 'value': '100'},
  {'name': 'Kawiarnia Wawel', 'value': '30-50'},
  // Add more data
];

final eventsData = [
  {'name': 'Krakowski Festiwal Filmowy', 'value': '10-15'},
  {'name': 'Krakowskie Targi Książki', 'value': '5-10'},
  // Add more data
];
