import 'package:flutter/material.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/organisms/o_used_clothes_box.dart';

class UsedDetailSectionAllHistory extends StatefulWidget {
  const UsedDetailSectionAllHistory({super.key, required this.items});
  final List<UsedHistoryClothesDetailModel?> items;

  @override
  StateUsedDetailSectionAllHistory createState() =>
      StateUsedDetailSectionAllHistory();
}

class StateUsedDetailSectionAllHistory
    extends State<UsedDetailSectionAllHistory> {
  late ClothesQueriesService apiQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items
          .map((dt) => OrganismsUsedClothesBox(
                item: dt,
                source: "clothes_history",
              ))
          .toList(),
    );
  }
}
