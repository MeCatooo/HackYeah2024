import 'package:flutter/material.dart';

class AnswerBubble extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerBubble({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: isSelected ? Colors.white : Colors.black,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
