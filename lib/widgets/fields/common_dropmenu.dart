import 'package:flutter/material.dart';
import 'package:ntt_data/core/constants/app_colors.dart';

class CommonDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;
  final String label;
  final String Function(T) itemToString;

  const CommonDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.label,
    required this.itemToString,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors.blackColor),
        labelText: label,
        filled: true,
        fillColor: AppColors.btntext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      icon: Icon(Icons.arrow_drop_down),
      style: TextStyle(fontSize: 16, color: Colors.black),
      items:
          items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemToString(item)),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
