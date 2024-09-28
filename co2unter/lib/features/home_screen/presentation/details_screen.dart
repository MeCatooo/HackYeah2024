// lib/features/home_screen/widgets/detail_dialog.dart

import 'package:flutter/material.dart';

class DetailDialog extends StatefulWidget {
  final String title;
  final String imageAsset;
  final List<Map<String, dynamic>> data;
  final String unit;

  const DetailDialog({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.data,
    required this.unit,
  }) : super(key: key);

  @override
  _DetailDialogState createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  List<Map<String, dynamic>> filteredData = [];
  TextEditingController searchController = TextEditingController();

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
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Image.asset(
            widget.imageAsset,
            height: 100,
            width: double.infinity,
            fit: BoxFit.contain,
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
          hintText: 'Wyszukaj',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _buildDataList() {
    return ListView.builder(
      itemCount: filteredData.length + 1, // +1 for the header row
      itemBuilder: (context, index) {
        if (index == 0) {
          // Header row
          return ListTile(
            title: Text(
              widget.title == 'Transport' ? 'Środek transportu' : widget.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              widget.unit,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
        final item = filteredData[index - 1];
        return ListTile(
          title: Text(item['name']),
          trailing: Text(item['value']),
          tileColor: index.isOdd ? Colors.grey[200] : Colors.white,
        );
      },
    );
  }
}
