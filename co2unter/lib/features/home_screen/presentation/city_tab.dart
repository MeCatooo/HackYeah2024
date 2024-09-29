import 'package:flutter/material.dart';
import '../widgets/expandable_card.dart';

class CityTab extends StatelessWidget {
  const CityTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildCard(
          context,
          'Transport',
          'assets/images/transport.png',
          'Środek transportu',
          'gramy CO2/km',
          transportData,
        ),
        _buildCard(
          context,
          'Usługi',
          'assets/images/services.png',
          'Usługa',
          'kilogramy CO2/dzień',
          servicesData,
        ),
        _buildCard(
          context,
          'Wydarzenia',
          'assets/images/events.png',
          'Wydarzenie',
          'ton CO2',
          eventsData,
        ),
        _buildCard(context, 'Inicjatywy', 'assets/images/initiatives.png',
            'Inicjatywa', 'Tony CO2', initiativesData),
        _buildCard(
            context, 'Parki', 'assets/images/parks.png', 'Park', '?', parksData)
      ],
    );
  }

  Widget _buildCard(BuildContext context, String title, String imageAsset,
      String columnName, String unitName, List<Map<String, dynamic>> data) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExpandableCard(
              title: title,
              imageAsset: imageAsset,
              columnName: columnName,
              unitName: unitName,
              data: data,
            ),
          ),
        );
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Image.asset(
                imageAsset,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final transportData = [
  {
    'name': 'Samochód spalinowy',
    'value': '150-300',
    'additionalInfo':
        'Samochody spalinowe emitują znaczną ilość CO2. Rozważ alternatywne środki transportu lub przejście na pojazd elektryczny.'
  },
  {
    'name': 'Samochód elektryczny',
    'value': '50-100',
    'additionalInfo':
        'Samochody elektryczne mają niższą emisję CO2, szczególnie gdy są zasilane energią ze źródeł odnawialnych.'
  },
  {
    'name': 'Autobus',
    'value': '40-80',
    'additionalInfo':
        'Transport publiczny, jak autobusy, znacząco redukuje emisję CO2 na osobę w porównaniu z prywatnymi samochodami.'
  },
  {
    'name': 'Rower',
    'value': '0',
    'additionalInfo':
        'Jazda na rowerze nie emituje CO2 i jest świetna dla zdrowia oraz środowiska.'
  },
];

final servicesData = [
  {
    'name': 'Restauracja Pod Wawelem',
    'value': '100',
    'additionalInfo':
        'Emisja CO2 w restauracjach zależy od wielu czynników, w tym źródeł energii, menu i praktyk gospodarowania odpadami.'
  },
  {
    'name': 'Kawiarnia Wawel',
    'value': '30-50',
    'additionalInfo':
        'Kawiarnie często mają niższą emisję CO2 niż pełne restauracje ze względu na mniejsze zużycie energii w procesie przygotowania.'
  },
];

final eventsData = [
  {
    'name': 'Krakowski Festiwal Filmowy',
    'value': '10-15',
    'additionalInfo':
        'Duże wydarzenia, takie jak festiwale filmowe, mogą generować znaczną emisję CO2 ze względu na transport, oświetlenie i inne czynniki.'
  },
  {
    'name': 'Krakowskie Targi Książki',
    'value': '5-10',
    'additionalInfo':
        'Targi książki mają zwykle mniejszy wpływ na środowisko niż niektóre inne rodzaje wydarzeń, ale nadal generują emisję CO2.'
  },
];

final initiativesData = [
  {
    'name': 'Budowa S7',
    'value': '54000',
    'additionalInfo':
        'Budowa drogi S7 jest nie tylko ogromną inwestycją pieniężną ale również środowiskową.'
  },
];

final parksData = [
  {
    'name': 'Park Jordana',
    'value': '?',
    'additionalInfo':
        'Parki miejskie są ważne dla jakości życia mieszkańców miasta i mogą pomóc w absorpcji CO2 oraz poprawie jakości powietrza.'
  },
  {
    'name': 'Planty',
    'value': '?',
    'additionalInfo':
        'Zielone obszary w mieście, takie jak Planty, są ważne dla zdrowia i środowiska, pomagając w absorpcji CO2 i poprawie jakości powietrza.'
  },
];
