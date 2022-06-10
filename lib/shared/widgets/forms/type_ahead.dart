import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ionicons/ionicons.dart';

class TypeAheadForm extends StatelessWidget {
  final String? hintText;
  final void Function(dynamic) onSuggestionSelected;
  final FutureOr<Iterable<dynamic>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  const TypeAheadForm(
      {Key? key,
      required this.hintText,
      required this.onSuggestionSelected,
      required this.suggestionsCallback,
      required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: const Icon(Ionicons.person_outline),
          ),
        ),
        suggestionsCallback: suggestionsCallback,
        itemBuilder: itemBuilder,
        onSuggestionSelected: onSuggestionSelected,
      ),
    );
  }
}
