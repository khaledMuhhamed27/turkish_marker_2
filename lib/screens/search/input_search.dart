import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class InputSearch extends StatefulWidget {
  final Function(String)? onChanged;
  const InputSearch({super.key, required this.onChanged});

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  bool showClearIcon = false;
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xFFB42318), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.symmetric(horizontal: 6),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: Color(0xFFD92D20),
                borderRadius: BorderRadius.circular(8)),
            child: SvgPicture.asset("assets/images/search.svg"),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: TextFormField(
                cursorColor: Color(0xFFD92D20),
                controller: controller,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintText: "searchh".tr(),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFFD92D20))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
