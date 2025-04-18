import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wardrobe/design_tokens/style.dart';

class OrganismsSuccessDialog extends StatelessWidget {
  const OrganismsSuccessDialog({super.key, this.text, this.keyName});
  final String? text;
  final String? keyName;

  @override
  Widget build(BuildContext context) {
    //double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(spaceSM),
      title: null,
      key: Key(keyName ?? '-'),
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
                child: Image.asset('assets/icon/Success.png', width: 120),
              ),
              const SizedBox(height: spaceLG),
              const Text("Success",
                  style:
                      TextStyle(fontSize: textLG, fontWeight: FontWeight.bold)),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, spaceMini, 0, spaceSM),
                  child: Text(text ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: textXMD, fontWeight: FontWeight.w500))),
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
                        color: successBG,
                        borderRadius:
                            BorderRadius.all(Radius.circular(roundedMD))),
                    child: Text("OK".tr,
                        style: const TextStyle(
                            color: whiteColor, fontWeight: FontWeight.w500)),
                  ))
            ]),
      ),
    );
  }
}
