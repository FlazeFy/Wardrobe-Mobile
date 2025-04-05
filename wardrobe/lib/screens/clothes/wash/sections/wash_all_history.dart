import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/organisms/o_clothes_header.dart';
import 'package:wardrobe/organisms/o_wash_box.dart';

class WashSectionAllHistory extends StatefulWidget {
  const WashSectionAllHistory({super.key});

  @override
  StateWashSectionAllHistory createState() => StateWashSectionAllHistory();
}

class StateWashSectionAllHistory extends State<WashSectionAllHistory> {
  late ClothesQueriesService apiQuery;
  List<WashHistoryModel> dt = [];
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
    var data = await apiQuery.getAllWashHistory(1);
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

  Widget _buildListView(List<WashHistoryModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: data.map((dt) => OrganismsWashBox(item: dt)).toList(),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
