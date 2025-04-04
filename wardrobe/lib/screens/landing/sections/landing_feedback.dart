import 'package:flutter/material.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/question/model/queries.dart';
import 'package:wardrobe/modules/api/question/service/queries.dart';
import 'package:wardrobe/molecules/m_feedback_box.dart';

class LandingSectionFeedback extends StatefulWidget {
  const LandingSectionFeedback({super.key});

  @override
  State<LandingSectionFeedback> createState() => _LandingSectionFeedbackState();
}

class _LandingSectionFeedbackState extends State<LandingSectionFeedback> {
  QuestionQueriesService? apiService;

  @override
  void initState() {
    super.initState();
    apiService = QuestionQueriesService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService?.getTopFeedback(),
        builder: (BuildContext context,
            AsyncSnapshot<TopFeedbackResponse?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            TopFeedbackResponse? contents = snapshot.data;

            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(TopFeedbackResponse? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            AtomsText(
              type: "content-title",
              text: "${data?.average.toString()} Average Rate,",
              color: blackColor,
            ),
            const SizedBox(width: spaceXXSM),
            AtomsText(
                type: "content-title",
                text: "from total ${data?.total.toString()} feedback",
                color: darkColor),
          ],
        ),
        const Row(
          children: [
            AtomsText(
              type: "content-title-main",
              text: "What",
              color: blackColor,
            ),
            SizedBox(width: spaceXSM),
            AtomsText(
                type: "content-title-main", text: "they say?", color: infoBG),
          ],
        ),
        SizedBox(
          height: 65,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data?.data.length,
            itemBuilder: (context, index) {
              final item = data?.data[index];
              return MoleculesFeedbackBox(item: item);
            },
          ),
        ),
        const SizedBox(height: spaceXLG)
      ],
    );
  }
}
