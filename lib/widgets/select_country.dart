import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectCountryInput extends StatelessWidget {
  TextEditingController controller;
  void Function()? onTap;
  SelectCountryInput({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "requird_ino".tr();
        }
        return null;
      },
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: 'select_cry_yoour'.tr(),
        suffixIcon: Icon(Icons.arrow_drop_down),
        // Erorr
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
