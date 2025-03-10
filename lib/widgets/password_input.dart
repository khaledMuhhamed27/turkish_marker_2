import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController? yourController;
  const PasswordInput({super.key, this.yourController});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool iconOfOn = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "requird_ino".tr();
        }
        return null;
      },
      controller: widget.yourController,
      cursorColor: Colors.grey,
      obscureText: iconOfOn,
      obscuringCharacter: '●',
      decoration: InputDecoration(
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
        suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                iconOfOn = !iconOfOn;
              });
            },
            child: Icon(
              iconOfOn ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey.shade600,
            )),
        hintText: 'pass_enter'.tr(),
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
