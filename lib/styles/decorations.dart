import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import 'colors.dart';

class Decorations{
  static InputDecoration searchFieldDecoration() {
    return InputDecoration(
      hintText: S.current.searchHint,
      hintStyle: TextStyle(color: colors["white"]!, fontStyle: FontStyle.italic),
      // When the input it's enabled
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: colors["white"]!),
      ),
      // When the input it's disabled
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: colors["white"]!),
      ),
      // When the input it's focused without any errors
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: colors["white"]!),
      ),
    );
  }
}