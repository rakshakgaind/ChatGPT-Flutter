import 'dart:async';
import 'dart:io';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../app_colors/colors.dart';
import '../main.dart';
import '../screens/chatMessage2.dart';
import 'base_provider.dart';
class ChatScreenProvider extends BaseProvider{


  final TextEditingController textFieldController = TextEditingController();
  final ScrollController listViewController=ScrollController();
  final List<ChatMessage> messages = [];
  late OpenAI? chatGPT;
  bool isTyping = false;
  bool isImageSearch = false;
  static Color buttonGradient1 = const Color(0xFF4FA599).withOpacity(0.86);
  static Color buttonGradient2 = const Color(0xFF027766).withOpacity(0.86);
  /// speech to text methods--
  late stt.SpeechToText speech;
  bool isListening = false;
  bool available = false;
  bool shoWLanguages=false;

  var showAlwaysKeyboard = true;
  String? selectedLanguage;
  String? newSelectedLanguage;

  /// send message method  & use below url for API Token Key & Please Don't Share Your Api Token Key--->
  /// Link for api - https://beta.openai.com/account/api-keys

  void _sendMessage() async {
    if (textFieldController.text.trim().isEmpty) return;
    ChatMessage message = ChatMessage(
      text: textFieldController.text.trim(),
      sender: "user",
      isImage: false,
    );

    notifyListeners();
    messages.insert(0, message);
    isTyping = true;
    textFieldController.clear();

    if (isImageSearch) {
      final request = GenerateImage(
        message.text,
        1,
        size: "256x256",
      );
      final response = await chatGPT!.generateImage(request);
      Vx.log(response!.data!.last!.url!);
      insertNewData(response.data!.last!.url!, isImage: true);
    } else {
      final request = CompleteText(
          prompt:  message.text,
          model: "text-davinci-003",
          maxTokens: 100);
      final response = await chatGPT!.onCompleteText(request: request);
      Vx.log(response!.choices[0].text);
      insertNewData(response.choices[0].text,);
      tts.setLanguage("हिन्दी",);
     // tts.speak(response.choices[0].text,);
    }
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "AI",
      isImage: isImage,
    );
    isImageSearch=false;
    isTyping = false;
    messages.insert(0, botMessage);
    notifyListeners();
  }

  /// Listen Method for speech--->
  void listen(BuildContext context) async {
    try{
      if (!isListening) {
        available = await speech.initialize(
          onStatus: (val) {debugPrint("<---on status-->$val");
          if (val == "done") {
            isListening = false;
            notifyListeners();
          }
          },
          onError: (val) => debugPrint("<---on error-->$val"),
        );
      }
      if (available) {
        notifyListeners();
        isListening = true;

        speech.listen(
            onResult: (val) {
              textFieldController.text = val.recognizedWords;
              textFieldController.selection = TextSelection.fromPosition(TextPosition(offset: textFieldController.text.length));
              Vx.log(textFieldController.text.trim());
            },
            listenFor: Platform.isIOS ? const Duration(seconds: 5) : null);
      }
    }catch(e){
      debugPrint("<---exception--->$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            onPressed: () {
              // Code to execute.
            }, label: 'Dismiss',
          ),
          content:  const Text("Speech recognition not available on this device"),
          duration: const Duration(milliseconds: 1500),
          width: 280.0, // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0, // Inner padding for SnackBar content.
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

    }


  }

  var focusNode=FocusNode();

  void callFocus(BuildContext context,bool fromPopup) {
    focusNode.addListener(() {

      if(focusNode.hasFocus)
      {
        debugPrint("<--focus hai--${focusNode.hasFocus}");

        if(fromPopup){
          FocusScope.of(context).requestFocus(focusNode);
        }
      }else if(!focusNode.hasFocus){
        debugPrint("<--focus nhi hai--${focusNode.hasFocus}");

        if(fromPopup){
          FocusScope.of(context).requestFocus(focusNode);
        }
      }


    });
  }

  /// send button with text field--->
  Widget buildTextComposer(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            onEditingComplete: (){
              focusNode.requestFocus(focusNode);
            },
            autofocus: false,
            focusNode: focusNode,
            controller: textFieldController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  notifyListeners();
                  isListening = !isListening;
                  listen(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  isListening ?
                      Image.asset("assets/images/mic.png",height: 25,)
                      : const Icon(Icons.mic_off,color: AppColors.dotColor,),
                )),
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 50,
                minWidth: 50
              ),
              hintText: 'Type a Message...',
              disabledBorder: InputBorder.none,
              hintStyle: const TextStyle(fontSize: 16,
              fontWeight: FontWeight.w200,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(top: 10,bottom: 10,left: 20),
            ),
          ),
        ),
      const SizedBox(width: 10,),
      GestureDetector(
        onTap: () {
          listViewController.animateTo(0.0, duration: const Duration(milliseconds: 20), curve: Curves.easeOut);
          isListening = false;
          _sendMessage();
        },
        child: Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
           gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  buttonGradient1,
                  buttonGradient2,
                ],
              ),
           //   borderRadius: BorderRadius.circular(20)
          ),

          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.transparent,
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset("assets/images/sendButton.png")),

            ),
          ),
        ),
      )

      ],
    );
  }

  void translateMessage(String language,String text) async {
    notifyListeners();
    isTyping = true;

    if (isImageSearch) {
      final request = GenerateImage(
        text,
        1,
        size: "256x256",
      );
      final response = await chatGPT!.generateImage(request);
      Vx.log(response!.data!.last!.url!);
      insertNewData(response.data!.last!.url!, isImage: true);
    } else {
      final request = CompleteText(
          prompt:
          language+ text,
          model: "text-davinci-003",
          maxTokens: 100);
      final response = await chatGPT!.onCompleteText(request: request);
      Vx.log(response!.choices[0].text);
      insertNewData(response.choices[0].text,);
      tts.speak(
        response.choices[0].text,
      );
    }
  }

  @override
  void dispose() {
    chatGPT?.close();
    chatGPT?.genImgClose();
    super.dispose();
  }
}