import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/api/auth/service/queries.dart';
import 'package:wardrobe/modules/api/clothes/service/commands.dart';
import 'package:wardrobe/screens/clothes/used/index.dart';
import 'package:wardrobe/screens/landing/index.dart';

class UsedSectionHardDeleteUsedHistory extends StatefulWidget {
  const UsedSectionHardDeleteUsedHistory({super.key, required this.id});
  final String id;

  @override
  StateUsedSectionHardDeleteUsedHistory createState() =>
      StateUsedSectionHardDeleteUsedHistory();
}

class StateUsedSectionHardDeleteUsedHistory
    extends State<UsedSectionHardDeleteUsedHistory> {
  late ClothesCommandsService apiCommand;
  @override
  void initState() {
    super.initState();
    apiCommand = ClothesCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    return AtomsButton(
      type: "btn-icon",
      color: dangerBG,
      icon: const FaIcon(
        FontAwesomeIcons.trash,
        color: whiteColor,
        size: textXLG,
      ),
      action: () {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                showCancelBtn: true,
                onCancel: () {
                  Get.back();
                },
                onConfirm: () async {
                  try {
                    var response =
                        await apiCommand.deleteUsedClothesHistory(widget.id);
                    if (response[0]['status'] == 'success') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UsedPage()),
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
                text: "Want to permanentally delete this history?"));
      },
    );
  }
}
