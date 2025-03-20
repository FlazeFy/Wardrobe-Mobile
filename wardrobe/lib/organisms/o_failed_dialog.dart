import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:wardrobe/modules/helpers/converter.dart';

class OrganismsFailedDialog extends StatefulWidget {
  const OrganismsFailedDialog({super.key, this.text, this.type});
  final dynamic text;
  final String? type;

  @override
  StateFailedDialog createState() => StateFailedDialog();
}

class StateFailedDialog extends State<OrganismsFailedDialog> {
  @override
  Widget build(BuildContext context) {
    double fullWidth = Get.width;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(spaceSM),
      title: null,
      backgroundColor: whiteColor,
      content: SizedBox(
        width: fullWidth,
        height: 320,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(roundedJumbo + roundedJumbo),
                child: Image.asset('assets/icon/Failed.png', width: 120),
              ),
              const SizedBox(height: spaceLG),
              const Text("Failed",
                  style:
                      TextStyle(fontSize: textLG, fontWeight: FontWeight.bold)),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, spaceMini, 0, spaceSM),
                  child: Text(
                      getMessageResponseFromObject(widget.text, widget.type),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: textXMD))),
              const Divider(
                height: spaceMD,
                color: greyColor,
              ),
              InkWell(
                  onTap: () => Navigator.pop(context, 'OK'),
                  child: Container(
                    padding: const EdgeInsets.all(spaceMD),
                    margin: const EdgeInsets.only(top: spaceMD),
                    decoration: const BoxDecoration(
                        color: dangerBG,
                        borderRadius:
                            BorderRadius.all(Radius.circular(roundedMD))),
                    child: const Text("Try Again",
                        style: TextStyle(
                            color: whiteColor, fontWeight: FontWeight.w500)),
                  ))
            ]),
      ),
    );
  }
}
