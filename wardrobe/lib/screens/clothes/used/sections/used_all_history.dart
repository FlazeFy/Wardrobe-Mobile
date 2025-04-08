import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/organisms/o_used_clothes_box.dart';

class UsedSectionAllHistory extends StatefulWidget {
  const UsedSectionAllHistory({super.key});

  @override
  StateUsedSectionAllHistory createState() => StateUsedSectionAllHistory();
}

class StateUsedSectionAllHistory extends State<UsedSectionAllHistory> {
  late ClothesQueriesService apiQuery;
  List<UsedHistoryModel> dt = [];
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
    var data = await apiQuery.getAllUsedHistory(1, 'desc');
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

  Widget _buildListView(List<UsedHistoryModel> data) {
    if (data.isNotEmpty) {
      return Column(
        children: data.map((dt) => OrganismsUsedClothesBox(item: dt)).toList(),
      );
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
