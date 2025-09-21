import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final int color;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.color,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(category),
      labelStyle: TextStyle(color: isSelected ? Colors.white : Color(color)),
      backgroundColor: Colors.transparent,
      selected: isSelected,
      selectedColor: Color(color),
      checkmarkColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: Color(color))),
      onSelected: (_) => onTap(),
    );
  }
}
