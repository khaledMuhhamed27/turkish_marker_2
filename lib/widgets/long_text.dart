import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LongTextM extends StatelessWidget {
  const LongTextM({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sized
          SizedBox(height: 20),
          // 1
          AutoSizeText(
            "down_text_1".tr(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          //2
          AutoSizeText(
            textAlign: TextAlign.left,
            "down_text_2".tr(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'down_text_3'.tr(),
              style: TextStyle(fontSize: 16, color: Colors.indigoAccent),
              children: [
                TextSpan(text: ',', style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: 'down_text_4'.tr(),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                    text: 'down_text_5'.tr(),
                    style: TextStyle(color: Colors.blue)),
                TextSpan(
                  text: 'down_text_6'.tr(),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // My Button
        ],
      ),
    );
  }
}

class MyButtonR extends StatefulWidget {
  final VoidCallback myOnPressed;
  const MyButtonR({super.key, required this.myOnPressed});

  @override
  State<MyButtonR> createState() => _MyButtonRState();
}

class _MyButtonRState extends State<MyButtonR> {
  @override
  Widget build(BuildContext context) {
    return
        // My Button
        MaterialButton(
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 12),
      minWidth: double.infinity,
      color: Color(0xff475467),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: widget.myOnPressed,
      child: Text(
        "register".tr(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MyFinalText extends StatelessWidget {
  final VoidCallback textButtonPressed;
  const MyFinalText({
    super.key,
    required this.textButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        TextButton(
          onPressed: textButtonPressed,
          child: Text(
            "Log in",
            style: TextStyle(
              color: Colors.red[800],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        )
      ],
    ));
  }
}
