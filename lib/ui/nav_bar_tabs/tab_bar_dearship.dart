import 'package:flutter/material.dart';
import 'package:turkesh_marketer/screens/home/dealership_screens/cooperation_screen.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';
import 'package:turkesh_marketer/widgets/circle_background.dart';

class CustomTabBarShipScreen extends StatefulWidget {
  const CustomTabBarShipScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTabBarShipScreen createState() => _CustomTabBarShipScreen();
}

class _CustomTabBarShipScreen extends State<CustomTabBarShipScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  int _selectedIndex = 0;
  String titleNav = "Franchise";
  final List<String> tabs = [
    "Franchise",
    "Wholeasale",
    "Online Sale",
    "Service Provider",
    "Authorized Agent",
  ];

  final List<Widget> pages = [
    CooperationScreen(type: 'franchise'),
    CooperationScreen(type: 'wholesale'),
    CooperationScreen(type: 'e_sale'),
    CooperationScreen(type: 'service_provider'),
    CooperationScreen(type: 'authorized_agent'),
  ];

  final List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _scrollController = ScrollController();
    _tabKeys.addAll(List.generate(tabs.length, (index) => GlobalKey()));

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCenter(_selectedIndex);
      });
    });
  }

  void _scrollToCenter(int index) {
    final RenderBox? renderBox =
        _tabKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      double tabPosition = renderBox.localToGlobal(Offset.zero).dx;
      double tabWidth = renderBox.size.width;
      double screenWidth = MediaQuery.of(context).size.width;
      bool isRTL = Directionality.of(context) == TextDirection.rtl;

      double scrollOffset = _scrollController.offset +
          (isRTL
              ? (tabPosition - (screenWidth / 2) + (tabWidth / 2)) * -1
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
    return Directionality(
      textDirection: TextDirection.ltr, // جرب تغييره إلى rtl عند الحاجة
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
                SizedBox(height: 12),
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFFEAECF0),
                      )),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    reverse: Directionality.of(context) ==
                        TextDirection.rtl, // عكس الاتجاه عند RTL
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
                                      BoxShadow(
                                        color: Color(0xff1018280f),
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 3),
                                      ),
                                      BoxShadow(
                                        color: Color(0xff1018281a),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 3),
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
                                    ? Color(0xFF344054)
                                    : Color(0xFF667085),
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
