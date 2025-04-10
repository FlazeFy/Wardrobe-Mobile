import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_input.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/service/commands.dart';
import 'package:wardrobe/screens/clothes/detail/index.dart';

class DetailSectionClothesDelete extends StatefulWidget {
  const DetailSectionClothesDelete(
      {Key? key, required this.id, required this.clothesName})
      : super(key: key);
  final String id;
  final String clothesName;

  @override
  StateDetailSectionClothesDeleteState createState() =>
      StateDetailSectionClothesDeleteState();
}

class StateDetailSectionClothesDeleteState
    extends State<DetailSectionClothesDelete> {
  ClothesCommandsService? apiCommand;
  final TextEditingController clothesNameController = TextEditingController();
  bool isDeleteDisabled = true;

  @override
  void initState() {
    super.initState();
    apiCommand = ClothesCommandsService();

    clothesNameController.addListener(() {
      final isMatch = clothesNameController.text == widget.clothesName;
      if (isDeleteDisabled != !isMatch) {
        setState(() {
          isDeleteDisabled = !isMatch;
        });
      }
    });
  }

  @override
  void dispose() {
    clothesNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: dangerBG.withOpacity(0.5),
        borderRadius: BorderRadius.circular(roundedLG),
      ),
      width: Get.width,
      padding: const EdgeInsets.all(spaceLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.triangleExclamation,
                size: textLG,
              ),
              SizedBox(width: spaceMini),
              AtomsText(
                type: "content-title",
                text: "Delete Clothes",
                color: blackColor,
                marginBottom: 0,
              )
            ],
          ),
          const SizedBox(height: spaceSM),
          const AtomsText(
            type: "content-body",
            text:
                "You can delete this clothes and still can be Recovered before it pass 30 days since it was deleted. And also you can permanentally delete it right now after normal delete if you want it dissapear before 30 days",
            color: blackColor,
            marginBottom: 0,
          ),
          const SizedBox(height: spaceMD),
          const AtomsText(
            type: "content-sub-title",
            text: "Re-Type your Clothes Name to Verify Delete",
            color: blackColor,
            marginBottom: 0,
          ),
          const SizedBox(height: spaceXXSM),
          AtomsInput(
            type: "input-text",
            controller: clothesNameController,
            action: () {},
          ),
          Row(
            children: [
              AtomsButton(
                isDisabled: isDeleteDisabled,
                type: "btn-danger",
                text: "Delete",
                icon: const FaIcon(
                  FontAwesomeIcons.trash,
                  color: whiteColor,
                  size: textMD,
                ),
                action: () async {
                  ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                          showCancelBtn: true,
                          onCancel: () {
                            Get.back();
                          },
                          onConfirm: () async {
                            try {
                              var response = await apiCommand
                                  ?.softDeleteClothes(widget.id);
                              if (response[0]['status'] == 'success') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPage(id: widget.id)),
                                );
                                Get.snackbar('Success', response[0]['message']);
                              } else {
                                Get.snackbar('failed', response[0]['message']);
                              }
                            } catch (e) {
                              Get.snackbar('error', 'something went wrong');
                            }
                          },
                          type: ArtSweetAlertType.question,
                          title: "Are you sure?",
                          text: "Want to delete this clothes?"));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
