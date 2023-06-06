import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showHint({required BuildContext context, required String hint}) =>
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text(hint)));