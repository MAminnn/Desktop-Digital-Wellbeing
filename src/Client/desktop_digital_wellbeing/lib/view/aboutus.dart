import 'package:flutter/material.dart';
import 'ui_manager.dart';
import 'sidebar.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool isTitleHover = false;
  bool isChaparLinkHover = false;
  bool isTelegramLinkHover = false;
  bool isInstagramLinkHover = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            UIManager.applicationCurrentTheme.colorScheme.background,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SideBar(selectedItemIndex: 2),
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: UIManager
                            .applicationCurrentTheme.colorScheme.primary),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 85),
                    margin: const EdgeInsets.only(top: 30),
                    child: RichText(
                        textDirection: TextDirection.rtl,
                        text: TextSpan(
                          onEnter: (e) => setState(() => isTitleHover = true),
                          onExit: (e) => setState(() => isTitleHover = false),
                          style: TextStyle(
                              color: isTitleHover
                                  ? UIManager.applicationCurrentTheme
                                      .colorScheme.background
                                      .withOpacity(0.6)
                                  : UIManager.applicationCurrentTheme
                                      .colorScheme.background,
                              shadows: [
                                Shadow(
                                    color: UIManager.applicationCurrentTheme
                                        .colorScheme.background,
                                    blurRadius: 35)
                              ],
                              fontSize: 55,
                              fontFamily: 'Cmonnear'),
                          text: "CRUSADERS",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrlString('https://crusaders.ir',
                                  mode:
                                      LaunchMode.externalNonBrowserApplication);
                            },
                        )),
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: UIManager
                            .applicationCurrentTheme.colorScheme.primary),
                    padding: const EdgeInsets.fromLTRB(80, 30, 80, 0),
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: Image.asset('assets/images/crusaders.jpg'),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text("طراح و برنامه نویس : Amin Karvizi",
                                style: TextStyle(
                                    fontFamily: UIManager.persianFont,
                                    fontSize: 22,
                                    color: UIManager.applicationCurrentTheme
                                        .colorScheme.onPrimary),
                                textDirection: TextDirection.rtl)),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: isChaparLinkHover
                                            ? UIManager
                                                .applicationCurrentTheme
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.4)
                                            : UIManager
                                                .applicationCurrentTheme
                                                .colorScheme
                                                .onPrimary,
                                        fontFamily: UIManager.persianFont,
                                        fontSize: 18),
                                    onEnter: (e) => setState(
                                        () => isChaparLinkHover = true),
                                    onExit: (e) => setState(
                                        () => isChaparLinkHover = false),
                                    text: "چاپار : mamin",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrlString(
                                            'https://crusaders.ir/chapar',
                                            mode: LaunchMode
                                                .externalNonBrowserApplication);
                                      },
                                  )),
                              RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: isTelegramLinkHover
                                            ? UIManager
                                                .applicationCurrentTheme
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.4)
                                            : UIManager
                                                .applicationCurrentTheme
                                                .colorScheme
                                                .onPrimary,
                                        fontFamily: UIManager.persianFont,
                                        fontSize: 18),
                                    onEnter: (e) => setState(
                                        () => isTelegramLinkHover = true),
                                    onExit: (e) => setState(
                                        () => isTelegramLinkHover = false),
                                    text: "تلگرام",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrlString('https://t.me/M_AminK',
                                            mode: LaunchMode
                                                .externalNonBrowserApplication);
                                      },
                                  )),
                              RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: isInstagramLinkHover
                                            ? UIManager
                                                .applicationCurrentTheme
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.4)
                                            : UIManager
                                                .applicationCurrentTheme
                                                .colorScheme
                                                .onPrimary,
                                        fontFamily: UIManager.persianFont,
                                        fontSize: 18),
                                    onEnter: (e) => setState(
                                        () => isInstagramLinkHover = true),
                                    onExit: (e) => setState(
                                        () => isInstagramLinkHover = false),
                                    text: "اینستاگرام",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrlString(
                                            'https://www.instagram.com/moamin___/',
                                            mode: LaunchMode
                                                .externalNonBrowserApplication);
                                      },
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ))
          ],
        ));
  }
}
