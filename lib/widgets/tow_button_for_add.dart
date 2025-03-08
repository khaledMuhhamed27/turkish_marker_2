import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TwoButton extends StatelessWidget {
  final void Function()? onPressed1;
  final void Function()? onPressed2;

  const TwoButton({super.key, this.onPressed1, required this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: onPressed1,
              color: Color(0xff475467),
              child: Text(
                "add_company".tr(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: MaterialButton(
              elevation: 2,
              padding: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: onPressed2,
              color: Colors.grey[100],
              child: Text(
                "skip".tr(),
                style: TextStyle(
                  color: Color(0xff475467),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
