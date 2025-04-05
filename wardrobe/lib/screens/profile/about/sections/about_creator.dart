import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wardrobe/atoms/a_button.dart';
import 'package:wardrobe/atoms/a_text.dart';
import 'package:wardrobe/design_tokens/style.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSectionCreator extends StatefulWidget {
  const AboutSectionCreator({super.key});

  @override
  State<AboutSectionCreator> createState() => _AboutSectionCreatorState();
}

class _AboutSectionCreatorState extends State<AboutSectionCreator> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(spaceLG),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [infoBG, primaryLightBG],
          ),
          border: Border.all(width: spaceMini / 2, color: whiteColor),
          borderRadius: const BorderRadius.all(Radius.circular(roundedJumbo)),
        ),
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AtomsText(
                  type: "content-title-main",
                  text: "About",
                  color: blackColor,
                ),
                SizedBox(width: spaceSM),
                AtomsText(
                  type: "content-title-main",
                  text: "Creator",
                ),
              ],
            ),
            const AtomsText(
              type: "content-sub-title",
              text:
                  "My Name is Leo, a Bachelor's degree graduate in Software Engineering from Telkom University (2023). Focused on Web Development and Mobile Development. Enjoys exploring new knowledge and seeking challenges. If you want to do collaboration or do you want to send me feedback? you can find me on :",
              color: blackColor,
              align: TextAlign.center,
            ),
            const SizedBox(height: spaceLG),
            Wrap(
              children: [
                AtomsButton(
                    type: 'btn-icon',
                    action: () async {
                      final url = Uri.parse(
                          'https://www.instagram.com/leonardhorante_08/');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: whiteColor,
                    )),
                const SizedBox(width: spaceMD),
                AtomsButton(
                    type: 'btn-icon',
                    action: () async {
                      final url = Uri.parse(
                          'https://www.linkedin.com/in/leonardho-rante-sitanggang');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: whiteColor,
                    )),
                const SizedBox(width: spaceMD),
                AtomsButton(
                    type: 'btn-icon',
                    action: () async {
                      final url = Uri.parse('https://github.com/FlazeFy');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      color: whiteColor,
                    )),
                const SizedBox(width: spaceMD),
                AtomsButton(
                    type: 'btn-icon',
                    action: () async {
                      final url = Uri.parse('mailto:flazen.edu@gmail.com');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.envelope,
                      color: whiteColor,
                    ))
              ],
            )
          ],
        ));
  }
}
