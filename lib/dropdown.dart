import 'package:flutter/material.dart';

Widget customDropDown(List<String> items, String value, void onChange(val)) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        value: value.isNotEmpty ? value : null,
        onChanged: (val) {
          onChange(val);
        },
        items: items
            .map<DropdownMenuItem<String>>(
              (e) => DropdownMenuItem(value: e, child: Text(e)),
            )
            .toList(),
      ));
}
