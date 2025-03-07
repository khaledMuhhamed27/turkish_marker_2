import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/cubit/search/cubit/search_cubit.dart';
import 'package:turkesh_marketer/cubit/search/cubit/search_state.dart';
import 'package:turkesh_marketer/screens/search/card_search.dart';
import 'package:turkesh_marketer/screens/search/input_search.dart';
import 'package:turkesh_marketer/screens/search/show_item_search.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';
import 'package:turkesh_marketer/widgets/circle_background.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color circleColor =
        isDarkMode ? Colors.black26 : Colors.blueGrey.shade50;
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: CircleBackgroundPainter(circleColor: circleColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Column(
              children: [
                CustomAppBar(
                  myLiftIcon: Icons.arrow_back,
                  myRightButton: false,
                  onLeftIconTap: () {
                    Navigator.pop(context);
                  },
                  titleScreen: "Search",
                ),
                SizedBox(height: 50),
                // TextField لإدخال النص
                InputSearch(
                  onChanged: (query) {
                    // استدعاء دالة البحث عند كل تغيير في النص
                    context.read<SearchCubit>().search(query);
                  },
                ),
                SizedBox(height: 20),

                // BlocBuilder للاستماع للحالات المختلفة
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    // حالة التحميل
                    if (state is SearchLoading) {
                      return LoadingWidgt();
                    }
                    // حالة النجاح - عرض الشركات التي تم جلبها
                    else if (state is SearchSuccess) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.result.companies.length,
                          itemBuilder: (context, index) {
                            final company = state.result.companies[index];
                            return MySearchCard(
                              createdAt: "2025-01-30T18:28:35.000000Z",
                              id: company.id,
                              title: company.title,
                              imageUrl: company.photo,
                              details: company.website,
                              onTap: () {
                                print(company.id);
                                // هنا يمكن إضافة صفحة التفاصيل إذا رغبت بذلك
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowItemSearch(
                                            id: company.id,
                                            title: company.title,
                                            imageUrl: company.photo,
                                            details: company.website,
                                            createdAt:
                                                "2025-01-30T18:28:35.000000Z",
                                          )),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }
                    // حالة الفشل - عرض رسالة الخطأ
                    else if (state is SearchFailure) {
                      return Center(child: Text('خطأ: ${state.error}'));
                    }
                    // حالة فارغة - عندما لا يكون هناك نص مدخل
                    else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
