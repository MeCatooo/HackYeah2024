import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final String imageAsset;
  final List<Map<String, dynamic>> data;
  final String columnName;
  final String unitName;

  const ExpandableCard({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.data,
    required this.columnName,
    required this.unitName,
  });

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  List<Map<String, dynamic>> filteredData = [];
  TextEditingController searchController = TextEditingController();
  Set<int> expandedItems = {};

  @override
  void initState() {
    super.initState();
    filteredData = widget.data;
    searchController.addListener(_filterData);
  }

  void _filterData() {
    setState(() {
      filteredData = widget.data
          .where((item) => item['name']
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildDataList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.black, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          Image.asset(
            widget.imageAsset,
            height: 170,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: 'Wyszukaj...',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildDataList() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.columnName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[600]),
              ),
              Text(
                widget.unitName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final item = filteredData[index];
              final isExpanded = expandedItems.contains(index);

              return Column(
                children: [
                  ListTile(
                    title: Text(item['name']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item['value']),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          expandedItems.remove(index);
                        } else {
                          expandedItems.add(index);
                        }
                      });
                    },
                  ),
                  if (isExpanded)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        item['additionalInfo'] ??
                            'No additional information available.',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  Divider(height: 1, color: Colors.grey[300]),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
