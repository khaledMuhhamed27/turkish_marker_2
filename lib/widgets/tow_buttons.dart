import 'package:flutter/material.dart';
import 'package:turkesh_marketer/screens/home/categories/category_screen.dart';

class TowButtons extends StatelessWidget {
  const TowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return // 2 Bottuns
        Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 48,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black54
              : Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xFFF9FAFB),
          )),
      child: Row(
        children: [
          // زر 1
          Expanded(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 1,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF424242) // لون الزر في الوضع الداكن
                  : Color(0xFFFFFFFF), // لون الزر في الوضع الفاتح
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CategoryScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Container(
                    height: 22,
                    width: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xFF616161)
                          : Color(0xFFF9FAFB),
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white24
                            : Color(0xFFEAECF0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xFF344054),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 10), // مسافة بين الزرين

          // زر 2
          Expanded(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 1,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF424242)
                  : Color(0xFFFFFFFF),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Countries",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Container(
                    height: 22,
                    width: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xFF616161)
                          : Color(0xFFF9FAFB),
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white24
                            : Color(0xFFEAECF0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xFF344054),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
