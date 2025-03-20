import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/organisms/o_clothes_header.dart';

class ClothesSectioAllHeader extends StatefulWidget {
  const ClothesSectioAllHeader({super.key});

  @override
  StateClothesSectioAllHeader createState() => StateClothesSectioAllHeader();
}

class StateClothesSectioAllHeader extends State<ClothesSectioAllHeader> {
  late ClothesQueriesService apiQuery;
  List<ClothesHeaderAllModel> dt = [];
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
    var data = await apiQuery.getAllClothesHeader(1);
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

  Widget _buildListView(List<ClothesHeaderAllModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: data.map((dt) => OrganismsClothesHeader(item: dt)).toList(),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
