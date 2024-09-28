// lib/features/home_screen/widgets/expandable_card.dart

import 'package:flutter/material.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final String imageAsset;
  final Widget expandedContent;

  const ExpandableCard({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.expandedContent,
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
      height: _isExpanded ? MediaQuery.of(context).size.height * 0.7 : 300,
      child: Card(
        color: theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: _isExpanded ? _buildExpandedView() : _buildCollapsedView(),
        ),
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
                  color: Colors.white,
                ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Image.asset(
            widget.imageAsset,
            height: 250,
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
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isExpanded = false;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.expandedContent,
            ),
          ),
        ),
      ],
    );
  }
}
