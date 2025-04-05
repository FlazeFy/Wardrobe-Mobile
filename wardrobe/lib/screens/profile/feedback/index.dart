import 'package:flutter/material.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:wardrobe/screens/profile/feedback/sections/feedback_send.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  StateFeedbackPageState createState() => StateFeedbackPageState();
}

class StateFeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(title: "Feedback")),
        body: ListView(
          padding: const EdgeInsets.all(spaceMD),
          children: const [FeedbackSectionSend()],
        ));
  }
}
