import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';

class AtomsInput extends StatelessWidget {
  final String type;
  final String? label;
  final dynamic action;
  final dynamic controller;

  const AtomsInput(
      {super.key,
      required this.type,
      this.label,
      this.action,
      this.controller});

  @override
  Widget build(BuildContext context) {
    if (type == 'input-text') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceSM),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: whiteColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: darkColor,
                  width: 1.25,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: darkColor,
                  width: 1.25,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: darkColor,
                  width: 1.25,
                ),
              ),
            ),
          ));
    } else {
      return const Text("Default Title");
    }
  }
}
