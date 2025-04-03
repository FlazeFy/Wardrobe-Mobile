import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';

class AtomsInput extends StatelessWidget {
  final String type;
  final String? label;
  final dynamic action;
  final dynamic controller;
  final Color? color;
  final String? keyName;

  const AtomsInput(
      {super.key,
      required this.type,
      this.label,
      this.action,
      this.color,
      this.controller,
      this.keyName});

  @override
  Widget build(BuildContext context) {
    if (type == 'input-text') {
      return Container(
          margin: const EdgeInsets.only(bottom: spaceSM),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            label != null
                ? AtomsText(
                    type: "input-label",
                    text: "$label",
                    color: color ?? whiteColor)
                : const SizedBox(),
            TextFormField(
              controller: controller,
              key: Key(keyName ?? '-'),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: spaceMini, horizontal: spaceSM),
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
            )
          ]));
    } else {
      return const Text("Default Title");
    }
  }
}
