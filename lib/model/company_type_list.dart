// company type
import 'package:flutter/material.dart';

final List<String> companyType = [
  "Exporter Company",
  "Importer Company",
  "Logistic Company",
  "Manufactory Company",
  "Wholesaler Company"
];

class MyDropDownList extends StatefulWidget {
  const MyDropDownList({super.key});

  @override
  State<MyDropDownList> createState() => _MyDropDownListState();
}

class _MyDropDownListState extends State<MyDropDownList> {
  String? myValue;
  String? selectedName;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: "Select Company",
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
      value: myValue,
      items: companyType.map((name) {
        return DropdownMenuItem(
          value: name,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedName = value;
          print(value);
        });
      },
    );
  }
}
