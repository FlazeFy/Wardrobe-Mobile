import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_input.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/auth/service/command.dart';
import 'package:wardrobe/modules/api/feedback/model/commands.dart';
import 'package:wardrobe/modules/api/feedback/service/commands.dart';
import 'package:wardrobe/organisms/o_bottom_bar.dart';
import 'package:wardrobe/screens/profile/feedback/index.dart';

class FeedbackSectionSend extends StatefulWidget {
  const FeedbackSectionSend({super.key});

  @override
  StateFeedbackSectionSend createState() => StateFeedbackSectionSend();
}

class StateFeedbackSectionSend extends State<FeedbackSectionSend> {
  final TextEditingController feedbackBodyCtrl = TextEditingController();
  final feedbackRatingCtrl = ValueNotifier<double>(4);

  late FeedbackCommandsService apiCommand;
  String allMsg = "";
  bool isLoadPost = false;

  @override
  void initState() {
    super.initState();
    apiCommand = FeedbackCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spaceLG),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(roundedXLG)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [infoBG, primaryLightBG],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AtomsText(
              type: "content-title-main", text: "Give Us", color: blackColor),
          const AtomsText(
            type: "content-title-main",
            text: "Feedback",
          ),
          const AtomsText(
            type: "content-sub-title",
            text:
                "Wardrobe is still at development, so your feedback will be very helpfull for us to improve.",
            align: TextAlign.center,
          ),
          const SizedBox(height: spaceMD),
          const AtomsText(
              type: "content-sub-title",
              text: "What do you think about our apps?",
              color: whiteColor),
          const SizedBox(height: spaceSM),
          AtomsInput(
            type: "input-text",
            label: null,
            controller: feedbackBodyCtrl,
            keyName: 'feedback-body-input',
            lines: 4,
          ),
          Row(
            children: [
              Column(
                children: [
                  const AtomsText(
                    type: "input-label",
                    text: "Rate us from 1 - 5",
                    color: whiteColor,
                  ),
                  AtomsInput(
                    type: "rating",
                    color: whiteColor,
                    minRating: 1,
                    maxRating: 5,
                    controller: feedbackRatingCtrl,
                  )
                ],
              ),
              const Spacer(),
              AtomsButton(
                  type: 'btn-success',
                  text: 'Seen Feedback',
                  action: () async {
                    String message = "";
                    String feedbackBody = feedbackBodyCtrl.text.trim();
                    double feedbackRate = feedbackRatingCtrl.value;
                    if (feedbackBody.isEmpty) {
                      if (feedbackBody.isEmpty) {
                        message = 'Username cant be empty';
                      }
                      Get.snackbar('Failed', message);
                    } else {
                      FeedbackModel data = FeedbackModel(
                          feedbackBody: feedbackBody,
                          feedbackRate: feedbackRate.toInt());
                      try {
                        var response = await apiCommand.postFeedback(data);
                        if (response[0]['status'] == 'success') {
                          Get.to(const FeedbackPage());
                          Get.snackbar('Success', response[0]['message']);
                        } else {
                          Get.snackbar('failed', response[0]['message']);
                        }
                      } catch (e) {
                        Get.snackbar('error', 'something went wrong');
                      }
                    }
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.solidFloppyDisk,
                    color: whiteColor,
                    size: spaceXMD,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
