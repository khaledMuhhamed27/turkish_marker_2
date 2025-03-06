import 'package:flutter/material.dart';

class MyButtonForm extends StatelessWidget {
  final TextEditingController? yourController;
  final TextInputType? yourkeybordType;
  const MyButtonForm({super.key, this.yourkeybordType, this.yourController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey[500],
      decoration: InputDecoration(
        hintText: "  www.example.com",
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
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.grey, width: 1), // خط فاصل
            ),
          ),
          child: Text(
            "https://",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 3),
          ),
        ),
      ),
      keyboardType: yourkeybordType,
    );
  }
}
