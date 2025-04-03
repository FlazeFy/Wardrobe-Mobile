import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/organisms/o_clothes_deleted_box.dart';

class TrashSectionAllDeletedClothes extends StatefulWidget {
  const TrashSectionAllDeletedClothes({super.key});

  @override
  StateTrashSectionAllDeletedClothes createState() =>
      StateTrashSectionAllDeletedClothes();
}

class StateTrashSectionAllDeletedClothes
    extends State<TrashSectionAllDeletedClothes> {
  late ClothesQueriesService apiQuery;
  List<ClothesDeletedModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiQuery = ClothesQueriesService();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    var data = await apiQuery.getAllDeletedClothes(1);
    setState(() {
      dt = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildListView(dt),
    );
  }

  Widget _buildListView(List<ClothesDeletedModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children:
            data.map((dt) => OrganismsClothesDeletedBox(item: dt)).toList(),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
