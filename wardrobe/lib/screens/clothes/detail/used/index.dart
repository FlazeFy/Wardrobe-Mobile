import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/clothes/detail/used/sections/used_all_history.dart';

class DetailUsedPage extends StatefulWidget {
  const DetailUsedPage(
      {Key? key, required this.items, required this.clothesName})
      : super(key: key);
  final List<UsedHistoryClothesDetailModel?> items;
  final String clothesName;

  @override
  StateUsedPageState createState() => StateUsedPageState();
}

class StateUsedPageState extends State<DetailUsedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Used History Page")),
        body: ListView(
          padding: const EdgeInsets.all(spaceMD),
          children: [
            AtomsText(
              type: "content-title",
              text: "History Of Used : ${widget.clothesName}",
              color: blackColor,
            ),
            UsedDetailSectionAllHistory(items: widget.items)
          ],
        ));
  }
}
