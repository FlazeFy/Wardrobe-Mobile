import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/clothes/trash/sections/trash_all_deleted_clothes.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({Key? key}) : super(key: key);

  @override
  StateTrashPageState createState() => StateTrashPageState();
}

class StateTrashPageState extends State<TrashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Trash Page")),
        body: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: spaceMD, vertical: spaceSM),
          children: const [
            AtomsText(type: "content-title", text: "Deleted Clothes"),
            AtomsText(
                type: "content-sub-title",
                text:
                    "All deleted clothes still can be recovered until 30 days after it got deleted. After that it will permanentally deleted"),
            SizedBox(height: spaceMD),
            TrashSectionAllDeletedClothes()
          ],
        ));
  }
}
