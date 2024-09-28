import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final String imageAsset;
  final List<Map<String, dynamic>> data;
  final String columnName;
  final String unitName;
  final Function(bool) onExpand;

  const ExpandableCard({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.data,
    required this.columnName,
    required this.unitName,
    required this.onExpand,
  }) : super(key: key);

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: _isExpanded ? MediaQuery.of(context).size.height * 0.8 : 150,
      decoration: BoxDecoration(
        color: _isExpanded ? Colors.transparent : theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: _isExpanded
            ? []
            : [const BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
          widget.onExpand(_isExpanded);
        },
        child: _isExpanded ? _buildExpandedView() : _buildCollapsedView(),
      ),
    );
  }

  Widget _buildCollapsedView() {
    return Stack(
      children: [
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black, // Dark title
                ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Image.asset(
            widget.imageAsset,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        _isExpanded = false;
                      });
                      widget.onExpand(false);
                    },
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black, // Dark title
                        ),
                  ),
                ],
              ),
              Image.asset(
                widget.imageAsset,
                height: 150,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              isDense: true,
              hintText: 'Wyszukaj...',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildDataTable(
                      widget.columnName, widget.unitName, widget.data),
                  const SizedBox(height: 20), // Add space below the table
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable(
      String columnName, String unitName, List<Map<String, dynamic>> data) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(columnName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(unitName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        ...data
            .map(
              (item) => TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item['name']),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item['value']),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}
