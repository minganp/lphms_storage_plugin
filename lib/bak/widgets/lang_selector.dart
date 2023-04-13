//drop down menu for language selection
//language from utility/lang_enum.dart file,langCode
import 'package:flutter/material.dart';
import 'package:lphms_storage_plugin/utility/lang_enum.dart';

Widget langSelector(ValueChanged langSelected) {
  List<DropdownMenuItem<String>> langItems = [];
  langCode.forEach((key, value) {
    langItems.add(DropdownMenuItem(
      value: key,
      child: Text(value),
    ));
  });
  return DropdownButton<String>(
    value: 'en',
    hint: const Text('Select Language'),
    items: langItems,
    onChanged: (lang) =>langSelected(lang),
  );
}
