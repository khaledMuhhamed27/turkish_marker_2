import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/theme_bloc.dart';
import 'package:turkesh_marketer/theme/app_theme.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';

class SettingTheme extends StatefulWidget {
  const SettingTheme({super.key});

  @override
  State<SettingTheme> createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          CustomAppBar(
            myLiftIcon: Icons.arrow_back,
            myRightButton: false,
            titleScreen: "choose_app".tr(),
            onLeftIconTap: () {
              Navigator.pop(context);

              print("Left icon tapped");
            },
          ),
          //
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 140),
                itemCount: AppTheme.values.length,
                itemBuilder: (context, index) {
                  final itemAppTheme = AppTheme.values[index];

                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color(0xFF98A2B3)
                                  : Color(0xFFF9FAFB),
                              width: 0.2),
                        ),
                        tileColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.black26
                                : Color(0xFFF9FAFB),
                        title: Text(
                          itemAppTheme.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Color(0xFF182230)),
                        ),
                        leading: Icon(
                          itemAppTheme.icon,
                          color: Color(0xFF475467),
                        ),
                        onTap: () {
                          context
                              .read<ThemeBloc>()
                              .add(ThemeChangedEvent(setTheme: itemAppTheme));
                        },
                      ));
                }),
          ),
        ],
      ),
    ));
  }
}
