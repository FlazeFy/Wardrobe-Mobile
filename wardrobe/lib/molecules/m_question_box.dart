import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/question/model/commands.dart';

class MoleculesQuestionBox extends StatelessWidget {
  final AskQuestionModel item;

  const MoleculesQuestionBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spaceLG),
      margin: const EdgeInsets.only(bottom: spaceMD),
      decoration: const BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.question,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Created at: ${item.createdAt}",
                    style: const TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
