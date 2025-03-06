import 'package:flutter/material.dart';

class TwoButton extends StatelessWidget {
  final void Function()? onPressed;
  const TwoButton({super.key, this.onPressed});

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
              onPressed: onPressed,
              color: Color(0xff475467),
              child: Text(
                "Add Company",
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
              onPressed: onPressed,
              color: Colors.grey[100],
              child: Text(
                "Skip To Home Page",
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
