import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:turkesh_marketer/screens/home/dealership_screens/cooperation_screen.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';
import 'package:turkesh_marketer/widgets/circle_background.dart';
import 'dart:ui' as ui;

class TabBarDearship extends StatefulWidget {
  const TabBarDearship({super.key});

  @override
  _TabBarDearship createState() => _TabBarDearship();
}

class _TabBarDearship extends State<TabBarDearship>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  int _selectedIndex = 0;
  String titleNav = "franc_tab".tr();
  List<String> tabs = [];
  final List<GlobalKey> _tabKeys = [];

  final List<Widget> pages = [
    CooperationScreen(type: 'franchise'),
    CooperationScreen(type: 'wholesale'),
    CooperationScreen(type: 'e_sale'),
    CooperationScreen(type: 'service_provider'),
    CooperationScreen(type: 'authorized_agent'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = ScrollController();
    _tabKeys.addAll(List.generate(5, (index) => GlobalKey()));

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        titleNav = tabs[_selectedIndex]; // تحديث العنوان عند تغيير التبويب
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCenter(_selectedIndex);
      });
    });

    _updateTabs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabs();
  }

  void _updateTabs() {
    setState(() {
      tabs = [
        "franc_tab".tr(),
        "whole_tab".tr(),
        "online_tab".tr(),
        "service".tr(),
        "autho_tab".tr(),
      ];
      titleNav = tabs[_selectedIndex]; // تحديث العنوان بناءً على اللغة الجديدة
    });
  }

  void _scrollToCenter(int index) {
    final RenderBox? renderBox =
        _tabKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      double tabPosition = renderBox.localToGlobal(Offset.zero).dx;
      double tabWidth = renderBox.size.width;
      double screenWidth = MediaQuery.of(context).size.width;
      bool isRTL = Directionality.of(context) == ui.TextDirection.rtl;

      double scrollOffset = _scrollController.offset +
          (isRTL
              ? (tabPosition - (screenWidth / 3) + (tabWidth / 3)) * 1
              : (tabPosition - (screenWidth / 2) + (tabWidth / 2)));

      _scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color circleColor =
        isDarkMode ? Colors.black26 : Colors.blueGrey.shade50;
    bool isRTL = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomPaint(
              size: Size(double.infinity, double.infinity),
              painter: CircleBackgroundPainter(circleColor: circleColor),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: CustomAppBar(
                    myLiftIcon: Icons.person_outline_outlined,
                    myRightButton: true,
                    titleScreen: titleNav,
                    onLeftIconTap: () {
                      Navigator.pushNamed(context, 'setting');
                    },
                    onRightIconTap: () {
                      Navigator.pushNamed(context, 'search');
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFEAECF0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    reverse: isRTL,
                    child: Row(
                      children: List.generate(tabs.length, (index) {
                        bool isSelected = _selectedIndex == index;
                        return GestureDetector(
                          key: _tabKeys[index],
                          onTap: () {
                            _tabController.animateTo(index);
                            setState(() {
                              _selectedIndex = index;
                              titleNav = tabs[index];
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: isSelected
                                  ? [
                                      const BoxShadow(
                                        color: Color(0xff1018280f),
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset: Offset(0, 3),
                                      ),
                                      const BoxShadow(
                                        color: Color(0xff1018281a),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(0, 3),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? const Color(0xFF344054)
                                    : const Color(0xFF667085),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: pages,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
