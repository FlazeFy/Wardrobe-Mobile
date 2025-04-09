import 'package:flutter/material.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/organisms/o_outfit_header.dart';

class GeneratedOutfitSectionAllOutfit extends StatefulWidget {
  const GeneratedOutfitSectionAllOutfit({super.key, required this.items});
  final List<OutfitModel?> items;

  @override
  StateGeneratedOutfitSectionAllOutfit createState() =>
      StateGeneratedOutfitSectionAllOutfit();
}

class StateGeneratedOutfitSectionAllOutfit
    extends State<GeneratedOutfitSectionAllOutfit> {
  late ClothesQueriesService apiQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items
          .map((dt) => OrganismsOutfitBox(
                data: dt,
              ))
          .toList(),
    );
  }
}
