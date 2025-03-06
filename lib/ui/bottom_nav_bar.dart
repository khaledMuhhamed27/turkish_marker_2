import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:turkesh_marketer/screens/home/categories/tim_categories.dart';
import 'package:turkesh_marketer/ui/nav_bar_tabs/tab_bar_dearship.dart';
import 'package:turkesh_marketer/ui/nav_bar_tabs/tab_bar_homs.dart';
import 'package:turkesh_marketer/screens/home/companies.dart';
import 'package:turkesh_marketer/ui/nav_bar_tabs/tab_bar_tenders.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(() {
      setState(() {}); // تحديث الواجهة عند تغيير التبويب
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PersistentTabConfig> _tabs(BuildContext context, int selectedIndex) => [
        PersistentTabConfig(
          screen: const CustomTabBarHomeScreen(),
          item: ItemConfig(
            activeForegroundColor: (selectedIndex == 0)
                ? (Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade300 // لون في Light Mode
                    : Color(0xFFD92D20)) // لون في Dark Mode
                : (Theme.of(context).brightness == Brightness.light
                    ? Color(0xFF98A2B3) // لون في Light Mode
                    : Colors.grey.shade700),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                (selectedIndex == 0)
                    ? (Theme.of(context).brightness == Brightness.dark
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Color(0xFFD92D20)) // لون في Dark Mode
                    : (Theme.of(context).brightness == Brightness.light
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Colors.grey.shade700), // لون في Dark Mode
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'assets/images/hom.svg',
                width: 24,
                height: 24,
              ),
            ),
            title: "nav_home".tr(),
          ),
        ),
        PersistentTabConfig(
          screen: CustomTabBarScreen(),
          item: ItemConfig(
            activeForegroundColor: (selectedIndex == 1)
                ? (Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade300 // لون في Light Mode
                    : Color(0xFFD92D20)) // لون في Dark Mode
                : (Theme.of(context).brightness == Brightness.light
                    ? Color(0xFF98A2B3) // لون في Light Mode
                    : Colors.grey.shade700),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                (selectedIndex == 1)
                    ? (Theme.of(context).brightness == Brightness.dark
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Color(0xFFD92D20)) // لون في Dark Mode
                    : (Theme.of(context).brightness == Brightness.light
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Colors.grey.shade700), // لون في Dark Mode
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'assets/images/impt.svg',
                width: 24,
                height: 24,
              ),
            ),
            title: "nav_imports".tr(),
          ),
        ),
        PersistentTabConfig(
          screen: const CustomTabBarShipScreen(),
          item: ItemConfig(
            activeForegroundColor: (selectedIndex == 2)
                ? (Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade300 // لون في Light Mode
                    : Color(0xFFD92D20)) // لون في Dark Mode
                : (Theme.of(context).brightness == Brightness.light
                    ? Color(0xFF98A2B3) // لون في Light Mode
                    : Colors.grey.shade700),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                (selectedIndex == 2)
                    ? (Theme.of(context).brightness == Brightness.dark
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Color(0xFFD92D20)) // لون في Dark Mode
                    : (Theme.of(context).brightness == Brightness.light
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Colors.grey.shade700), // لون في Dark Mode
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'assets/images/roew.svg',
                width: 24,
                height: 24,
              ),
            ),
            title: "nav_export".tr(),
          ),
        ),
        PersistentTabConfig(
          screen: const CompaniesScreen2(),
          item: ItemConfig(
            activeForegroundColor: (selectedIndex == 3)
                ? (Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade300 // لون في Light Mode
                    : Color(0xFFD92D20)) // لون في Dark Mode
                : (Theme.of(context).brightness == Brightness.light
                    ? Color(0xFF98A2B3) // لون في Light Mode
                    : Colors.grey.shade700),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                (selectedIndex == 3)
                    ? (Theme.of(context).brightness == Brightness.dark
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Color(0xFFD92D20)) // لون في Dark Mode
                    : (Theme.of(context).brightness == Brightness.light
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Colors.grey.shade700), // لون في Dark Mode
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'assets/images/cam.svg',
                width: 24,
                height: 24,
              ),
            ),
            title: "nav_company".tr(),
          ),
        ),
        PersistentTabConfig(
          screen: TimCategories(),
          item: ItemConfig(
            activeForegroundColor: (selectedIndex == 4)
                ? (Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade300 // لون في Light Mode
                    : Color(0xFFD92D20)) // لون في Dark Mode
                : (Theme.of(context).brightness == Brightness.light
                    ? Color(0xFF98A2B3) // لون في Light Mode
                    : Colors.grey.shade700),
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                (selectedIndex == 4)
                    ? (Theme.of(context).brightness == Brightness.dark
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Color(0xFFD92D20)) // لون في Dark Mode
                    : (Theme.of(context).brightness == Brightness.light
                        ? Color(0xFF98A2B3) // لون في Light Mode
                        : Colors.grey.shade700), // لون في Dark Mode
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'assets/images/cat.svg',
                width: 24,
                height: 24,
              ),
            ),
            title: "nav_category".tr(),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    bool hideNavBar = ModalRoute.of(context)?.settings.name == 'search';

    return PersistentTabView(
      controller: _controller,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      tabs: _tabs(context, _controller.index),
      navBarBuilder: (navBarConfig) => hideNavBar
          ? SizedBox
              .shrink() // إخفاء الـ BottomNavigationBar في ShowSubCategoryScreen
          : Style1BottomNavBar(
              navBarConfig: navBarConfig,
              navBarDecoration:
                  NavBarDecoration(color: Theme.of(context).primaryColor),
            ),
      navBarOverlap: NavBarOverlap.full(),
    );
  }
}
