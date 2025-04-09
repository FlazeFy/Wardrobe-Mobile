import 'package:flutter/material.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/queries.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/clothes/detail/sections/detail_clothes_header.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  StateDetailPageState createState() => StateDetailPageState();
}

class StateDetailPageState extends State<DetailPage> {
  ClothesQueriesService? apiQuery;
  @override
  void initState() {
    super.initState();
    apiQuery = ClothesQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiQuery?.getClothesDetail(widget.id),
        builder: (BuildContext context,
            AsyncSnapshot<ClothesDetailModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            ClothesDetailModel? content = snapshot.data;

            return _buildListView(content);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(ClothesDetailModel? data) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Used History Page")),
        body: ListView(children: [
          DetailSectionClothesHeader(
              clothesCategory: data?.detail.clothesCategory ?? "",
              clothesType: data?.detail.clothesType ?? "",
              clothesSize: data?.detail.clothesSize ?? "",
              clothesDesc: data?.detail.clothesDesc,
              clothesImage: data?.detail.clothesImage,
              id: widget.id,
              clothesName: data?.detail.clothesName ?? "")
        ]));
  }
}
