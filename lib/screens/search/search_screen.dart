import 'package:flutter/material.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: CustomAppBar(
              myLiftIcon: Icons.person_outline_outlined,
              onLeftIconTap: () {
                Navigator.pushNamed(context, 'setting');
              },
              myRightButton: true,
              titleScreen: "Search",
              onRightIconTap: () {
                Navigator.pushNamed(context, 'search');
              },
            ),
          ),
        ],
      ),
    );
  }
}
