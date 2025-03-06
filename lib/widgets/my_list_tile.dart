import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turkesh_marketer/theme/setting_theme.dart';

class MyListTileF extends StatelessWidget {
  final void Function()? onTap;
  final String titleC;
  final String? iconUrl;

  const MyListTileF({
    super.key,
    this.iconUrl,
    required this.titleC,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF98A2B3)
                  : Color(0xFFF9FAF5),
              width: Theme.of(context).brightness == Brightness.dark ? 0.2 : 1),
        ),
        tileColor: Theme.of(context).cardColor,
        onTap: onTap,
        title: Text(
          titleC,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).dividerColor),
        ),

        // Leading
        leading: iconUrl != null
            ? SvgPicture.asset(
                iconUrl!,
                width: 20,
                height: 20,
              )
            : SizedBox(),
        // Trailing
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
    );
  }
}

class MyListTiletheme extends StatelessWidget {
  const MyListTiletheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF98A2B3)
                    : Color(0xFFF9FAF5),
                width:
                    Theme.of(context).brightness == Brightness.dark ? 0.2 : 1),
          ),
          tileColor: Theme.of(context).cardColor,
          title: Text(
            "Change Theme",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).dividerColor),
          ),
          leading: Icon(
            Icons.contrast,
            color: Color(0xFF667085),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingTheme()));
          },
        ));
  }
}
