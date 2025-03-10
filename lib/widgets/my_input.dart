import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final TextEditingController yourController;
  final String yourHintText;
  final Widget? yourSurfsIcon;
  final Widget? yourPrefcsIcon;
  final TextInputType? yourTextInputType;
  final bool? isPassword;
  final int? minLine;
  final bool? enable;
  final String? Function(String?)? yourValidator;

  const MyInput({
    super.key,
    this.enable,
    required this.yourController,
    required this.yourHintText,
    this.yourSurfsIcon,
    this.isPassword,
    this.yourPrefcsIcon,
    this.yourTextInputType,
    this.minLine,
    this.yourValidator,
  });

  @override
  Widget build(BuildContext context) {
    return // input
        TextFormField(
      maxLines: minLine,
      validator: yourValidator,
      enabled: enable,
      controller: yourController,
      cursorColor: Colors.grey,
      keyboardType: yourTextInputType,
      // DECORATION
      decoration: InputDecoration(
        prefixIcon: yourPrefcsIcon,
        suffixIcon: yourSurfsIcon,
        hintText: yourHintText,
        hintStyle: TextStyle(color: Colors.black45),
        // Enable
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12)),

        // Focused
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12)),
        // Erorr
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12)),
        // border
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12)),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
