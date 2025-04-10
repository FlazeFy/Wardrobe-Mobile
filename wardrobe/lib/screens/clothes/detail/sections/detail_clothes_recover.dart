import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/clothes/service/commands.dart';
import 'package:wardrobe/screens/clothes/detail/index.dart';

class DetailSectionClothesRecover extends StatefulWidget {
  const DetailSectionClothesRecover({Key? key, required this.id})
      : super(key: key);
  final String id;

  @override
  StateDetailSectionClothesRecoverState createState() =>
      StateDetailSectionClothesRecoverState();
}

class StateDetailSectionClothesRecoverState
    extends State<DetailSectionClothesRecover> {
  ClothesCommandsService? apiCommand;

  @override
  void initState() {
    super.initState();
    apiCommand = ClothesCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return AtomsButton(
      type: "btn-success",
      text: "Recover",
      icon: const FaIcon(
        FontAwesomeIcons.rotateLeft,
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
                    var response = await apiCommand?.recoverClothes(widget.id);
                    if (response[0]['status'] == 'success') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(id: widget.id)),
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
                text: "Want to recover deleted clothes?"));
      },
    );
  }
}
