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
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF475467),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Add Company",
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Skip To Home Page",
                style: TextStyle(color: Color(0xFF475467)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
