import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/history/model/queries.dart';
import 'package:wardrobe/modules/api/history/service/queries.dart';
import 'package:wardrobe/organisms/o_history_box.dart';

class ProfileSectionAllHistory extends StatefulWidget {
  const ProfileSectionAllHistory({super.key});

  @override
  StateProfileSectionAllHistory createState() =>
      StateProfileSectionAllHistory();
}

class StateProfileSectionAllHistory extends State<ProfileSectionAllHistory> {
  late HistoryQueriesService apiQuery;
  List<HistoryModel> dt = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiQuery = HistoryQueriesService();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    var data = await apiQuery.getAllHistory(1);
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

  Widget _buildListView(List<HistoryModel> data) {
    if (data.isNotEmpty) {
      return Container(
          decoration: const BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
          padding: const EdgeInsets.all(spaceXMD),
          margin: const EdgeInsets.only(bottom: spaceMD),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const AtomsText(
                type: "content-title", text: "My History", color: blackColor),
            Column(
              children:
                  data.map((dt) => OrganismsHistoryBox(item: dt)).toList(),
            )
          ]));
    } else {
      return const Text("Unknown error, please contact the admin");
    }
  }
}
