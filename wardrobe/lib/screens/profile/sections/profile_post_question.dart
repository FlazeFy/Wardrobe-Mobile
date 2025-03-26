import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_input.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/question/model/commands.dart';
import 'package:wardrobe/modules/api/question/service/commands.dart';
import 'package:wardrobe/organisms/o_failed_dialog.dart';
import 'package:wardrobe/organisms/o_bottom_bar.dart';
import 'package:wardrobe/organisms/o_success_dialog.dart';

class ProfileSectionPostQuestion extends StatefulWidget {
  const ProfileSectionPostQuestion({super.key});

  @override
  StateProfileSectionPostQuestion createState() =>
      StateProfileSectionPostQuestion();
}

class StateProfileSectionPostQuestion
    extends State<ProfileSectionPostQuestion> {
  final TextEditingController questionCtrl = TextEditingController();
  late QuestionCommandsService apiCommand;
  String allMsg = "";
  bool isLoadPost = false;

  @override
  void initState() {
    super.initState();
    apiCommand = QuestionCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.all(Radius.circular(roundedLG))),
      padding: const EdgeInsets.all(spaceXMD),
      margin: const EdgeInsets.only(bottom: spaceMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AtomsText(type: "content-title", text: "Ask A Question"),
          const AtomsText(
              type: "content-sub-title",
              text:
                  "If you confused about how our apps work, or just want to make sure. Feel free to ask!"),
          AtomsInput(
            type: "input-text",
            label: null,
            controller: questionCtrl,
          ),
          Row(
            children: [
              AtomsButton(
                type: "btn-success",
                text: isLoadPost ? "Sending..." : "Send Question",
                icon: const FaIcon(FontAwesomeIcons.solidPaperPlane,
                    color: whiteColor, size: textMD),
                action: () async {
                  if (isLoadPost) return;

                  setState(() => isLoadPost = true);

                  String allMsg = "";
                  bool isValid = true;

                  if (questionCtrl.text.trim().isEmpty) {
                    isValid = false;
                    allMsg += "The question can't be empty.";
                  }

                  if (isValid) {
                    AskQuestionModel data = AskQuestionModel(
                      question: questionCtrl.text.trim(),
                    );

                    try {
                      var response = await apiCommand.postAskQuestion(data);
                      var status = response[0]['status'];
                      var msg = response[0]['message'] ?? "An error occurred";

                      if (status == 200) {
                        Get.to(const OrganismsBottomBar());
                        Get.dialog(OrganismsSuccessDialog(text: msg));
                        questionCtrl.clear(); // Clear input on success
                      } else {
                        Get.dialog(OrganismsFailedDialog(
                            text: msg, type: "add_question"));
                      }
                    } catch (e) {
                      Get.dialog(const OrganismsFailedDialog(
                          text: "Something went wrong. Please try again.",
                          type: "add_question"));
                    }
                  } else {
                    Get.dialog(OrganismsFailedDialog(text: allMsg, type: null));
                  }

                  setState(() => isLoadPost = false);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
