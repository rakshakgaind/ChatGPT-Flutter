import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../app_colors/colors.dart';
import '../main.dart';
import '../providers/chat_screen_provider.dart';

class ChatMessage extends StatefulWidget {
  String text;
  final String sender;
  final bool isImage;

  ChatMessage({
    Key? key,
    required this.text,
    required this.sender,
    required this.isImage,
  }) : super(key: key);

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  bool speakValue = false;

  void speak(bool speak) {
    if (speak) {
      tts.speak(widget.text);
    } else {
      tts.stop();
    }
  }

  late OpenAI? chatGPT;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(focusNode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    chatGPT = OpenAI.instance.build(
        token: "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",
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60000)));

    return Consumer<ChatScreenProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: widget.sender == "user"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  widget.sender == "user"
                      ? Container(
                          width: 300,
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12, top: 12),
                          decoration: const BoxDecoration(
                              color: AppColors.dotColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Text(
                            widget.text.trim(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))
                      :

                      /// chat gpt response design--->
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.dotColor,
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                      "assets/images/chatGptImage.png")),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 300,
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 12, top: 12),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: widget.isImage
                                  ? AspectRatio(
                                aspectRatio: 10 / 9,
                                child: Image.network(
                                  widget.text.trim(),
                                  loadingBuilder: (context, child,
                                      loadingProgress) =>
                                  loadingProgress == null
                                      ? child
                                      : const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child:
                                    CircularProgressIndicator(color: AppColors.dotColor),),
                                ),
                              )
                                  : Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(widget.text.trim(),
                                    style: Theme.of(context).textTheme.headlineSmall,),
                                  const SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      Padding(padding: const EdgeInsets.only(right: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {});
                                            speakValue = !speakValue;
                                            speak(speakValue);
                                          },
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                            AppColors.appThemeColor,
                                            child: SizedBox(
                                                height: 10,
                                                width: 10,
                                                child: Image.asset(
                                                    "assets/images/sound.png")),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            Clipboard.setData(
                                                ClipboardData(
                                                    text: widget.text));
                                            final snackBar = SnackBar(
                                              content: const Text(
                                                'Text copied',
                                                style: TextStyle(
                                                    color:
                                                    Colors.black),
                                              ),
                                              backgroundColor:
                                              (AppColors
                                                  .appThemeColor),
                                              action: SnackBarAction(
                                                label: 'dismiss',
                                                textColor:
                                                AppColors.dotColor,
                                                onPressed: () {},
                                              ),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          },
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                            AppColors.appThemeColor,
                                            child: SizedBox(
                                                height: 10,
                                                width: 10,
                                                child: Image.asset(
                                                    "assets/images/copy.png")),
                                          ),
                                        ),
                                      ),
                                      Consumer<ChatScreenProvider>(
                                        builder: (context,
                                            chatScreenProvider, child) {
                                          return PopupMenuButton(
                                              onOpened: () {
                                                setState(() {
                                                });
                                                chatScreenProvider.callFocus(context,true);
                                              },

                                              constraints:
                                              const BoxConstraints(
                                                minWidth: 137,
                                                maxWidth: 150,
                                              ),
                                              offset:
                                              const Offset(-10, 30),

                                              color: Colors.white,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(
                                                      20),
                                                  bottomRight:
                                                  Radius.circular(
                                                      20),
                                                  bottomLeft:
                                                  Radius.circular(
                                                      20),
                                                ),
                                              ),
                                              onSelected: (value) {},
                                              itemBuilder: (BuildContext bc) {
                                                return [
                                                  PopupMenuItem(child:
                                                  StatefulBuilder(
                                                    builder: (context,
                                                        StateSetter
                                                        setState) {
                                                      return FittedBox(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap:
                                                                    () {
                                                                  setState(
                                                                          () {});
                                                                  chatScreenProvider.shoWLanguages =
                                                                  !chatScreenProvider.shoWLanguages;
                                                                },
                                                                child:
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius: 10,
                                                                          backgroundColor: AppColors.appThemeColor,
                                                                          child: SizedBox(height: 10, width: 10, child: Image.asset("assets/images/languageImage.png")),
                                                                        ),
                                                                        const Text("Translate"),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 30),
                                                                      child: CircleAvatar(
                                                                        radius: 10,
                                                                        backgroundColor: AppColors.appThemeColor,
                                                                        child: Center(
                                                                            child: !chatScreenProvider.shoWLanguages
                                                                                ? const Icon(
                                                                              Icons.arrow_drop_down_sharp,
                                                                              size: 20,
                                                                            )
                                                                                : const Icon(
                                                                              Icons.arrow_drop_up,
                                                                              size: 20,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              chatScreenProvider
                                                                  .shoWLanguages
                                                                  ? Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      chatScreenProvider.translateMessage("Translate in Thai", widget.text);
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Container(
                                                                        alignment: Alignment.center,
                                                                        width: 130,
                                                                        decoration: BoxDecoration(color: AppColors.appThemeColor, borderRadius: BorderRadius.circular(20)),
                                                                        child: const Padding(
                                                                          padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                                                                          child: Text(
                                                                            "Thai",
                                                                            style: TextStyle(fontSize: 10),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () {
                                                                          chatScreenProvider.translateMessage("Translate in Japanese", widget.text);
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: Container(
                                                                            alignment: Alignment.center,
                                                                            width: 130,
                                                                            decoration: BoxDecoration(color: AppColors.appThemeColor, borderRadius: BorderRadius.circular(20)),
                                                                            child: const Padding(
                                                                              padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                                                                              child: Text(
                                                                                "Japanese",
                                                                                style: TextStyle(fontSize: 10),
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      chatScreenProvider.translateMessage("Translate in Hindi", widget.text);
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Container(
                                                                        alignment: Alignment.center,
                                                                        width: 130,
                                                                        decoration: BoxDecoration(color: AppColors.appThemeColor, borderRadius: BorderRadius.circular(20)),
                                                                        child: const Padding(
                                                                          padding: EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 5),
                                                                          child: Text(
                                                                            "Hindi",
                                                                            style: TextStyle(fontSize: 10),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ],
                                                              )
                                                                  : Container(),
                                                              GestureDetector(
                                                                onTap:
                                                                    () {
                                                                  chatScreenProvider.isImageSearch =
                                                                  true;
                                                                  chatScreenProvider.translateMessage(
                                                                      "",
                                                                      widget.text);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                Row(
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius: 10,
                                                                      backgroundColor: AppColors.appThemeColor,
                                                                      child: SizedBox(height: 10, width: 10, child: Image.asset("assets/images/generateImage.png")),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 3,
                                                                    ),
                                                                    const Text("Generate Image"),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                                    },
                                                  ))
                                                ];
                                              },
                                              child: const CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                AppColors
                                                    .appThemeColor,
                                                child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: Icon(
                                                      Icons.add,
                                                      color: AppColors
                                                          .dotColor,
                                                      size: 15,
                                                    )),
                                              ));
                                        },
                                      ),

                                    ],
                                  ),

                                ],
                              )
                            )
                          ],
                        )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
