import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../app_colors/colors.dart';
import '../providers/chat_screen_provider.dart';
import '../threedots.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
 const dotColor = Color(0xFF10A37F);

class _ChatScreenState extends State<ChatScreen> {

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatScreenProvider>(
      builder: (context, provider, child) {
        /// use your API Token Key
        /// Link for API Token Key  - https://beta.openai.com/account/api-keys
        /// Replace Token with Your unique Key
        debugPrint("<---chat screen--->");
        provider.chatGPT = OpenAI.instance.build(
            token: "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",
            baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60000)));
        provider.speech = stt.SpeechToText();
        return GestureDetector(
          onTap: () {

        var height=    MediaQuery.of(context).viewInsets.bottom;
        debugPrint("<--keyboard height--->$height");

          },
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
                backgroundColor: AppColors.appThemeColor,
                appBar: AppBar(
                    toolbarHeight: 78,
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    leading: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.appThemeColor,
                          child: SizedBox(
                              height: 10,
                              width: 16,
                              child: Image.asset("assets/images/backIcon.png")),

                        ),
                      ),
                    ),

                    title: Row(
                      children: [
                         CircleAvatar(
                           radius: 22,
                            backgroundColor: dotColor,
                          child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/images/chatGptImage.png")),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "ChatGPT",
                                style: Theme.of(context).textTheme.bodyLarge
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/onlineIcon.png",
                                  height: 8,
                                  width: 8,
                                ),
                                const SizedBox(width: 2,),
                                 Text("Always active", style: Theme.of(context).textTheme.bodyMedium
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )),
                body: SafeArea(
                    child: Column(
                  children: [
                    Flexible(
                        child: ListView.builder(
                          controller:provider.listViewController,
                          reverse: true,
                          padding: EdgeInsets.zero,
                         itemCount: provider.messages.length,
                         itemBuilder: (context, index) {
                        return provider.messages[index];
                      },
                    )),
                    if (provider.isTyping) const ThreeDots(),
                    Padding(padding: const EdgeInsets.all(8.0),
                      child: provider.buildTextComposer(context))
                  ],
                )
                ),
            ),
          ),
        );
      },
    );
  }
}
