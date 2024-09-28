// lib/features/home_screen/tabs/city_tab.dart

import 'package:flutter/material.dart';
import '../widgets/expandable_card.dart';

class CityTab extends StatelessWidget {
  const CityTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpandableCard(
          title: 'Usługi',
          imageAsset: 'assets/images/city1.png',
          expandedContent: _buildServicesContent(context),
        ),
        ExpandableCard(
          title: 'Transport',
          imageAsset: 'assets/images/city2.png',
          expandedContent: _buildTransportContent(context),
        ),
        ExpandableCard(
          title: 'Wydarzenia',
          imageAsset: 'assets/images/city3.png',
          expandedContent: _buildEventsContent(context),
        ),
      ],
    );
  }

  Widget _buildServicesContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informacje o emisji CO2 z sektora usług w Krakowie.',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
        // Add more widgets specific to services data
      ],
    );
  }

  Widget _buildTransportContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informacje o emisji CO2 związanej z transportem w Krakowie.',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
        // Add more widgets specific to transport data
      ],
    );
  }

  Widget _buildEventsContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dane o emisji CO2 podczas wydarzeń w Krakowie.',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
        // Add more widgets specific to events data
      ],
    );
  }
}
