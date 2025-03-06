import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_event.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_state.dart';
import 'package:turkesh_marketer/screens/home/categories/show_sub_category.dart';
import 'package:turkesh_marketer/ui/cartegory_card.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';
import 'package:turkesh_marketer/widgets/circle_background.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
   
  final GoogleTranslator translator = GoogleTranslator();
  Map<int, String> translatedTitles = {};
  String currentLang = 'ar';

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color circleColor =
        isDarkMode ? Colors.black26 : Colors.blueGrey.shade50;

    // تحديث اللغة عند تغيير `context.locale`
    String newLang = context.locale.languageCode;
    if (currentLang != newLang) {
      currentLang = newLang;
      translatedTitles.clear(); // إعادة الترجمة عند تغيير اللغة
    }
    return Scaffold(
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
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: CustomAppBar(
                  myLiftIcon: Icons.person_outline_outlined,
                  onLeftIconTap: () {
                    Navigator.pushNamed(context, 'setting');
                  },
                  myRightButton: true,
                  titleScreen: "Categories",
                  onRightIconTap: () {
                    Navigator.pushNamed(context, 'search');
                  },
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return LoadingWidgt(); // شاشة تحميل
                    }

                    if (state is CategoryLoaded) {
                      final loadedState = state;
                      _translateTitles(loadedState.categories); // ترجمة الفئات
                      var myCategoryList = ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: loadedState.categories.length,
                        itemBuilder: (context, index) {
                          final category = loadedState.categories[index];
                          return CartegoryCard(
                            title: translatedTitles[index] ?? category.name,
                            subtitle: category.description,
                            imageUrl: category.icon,
                            onTap: () {
                              BlocProvider.of<CategoryBloc>(context)
                                  .add(FetchSubcategories(category.id));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowSubCategoryScrren(
                                    category: category,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                      return myCategoryList;
                    }

                    if (state is CategoryError) {
                      final errorState = state;
                      return Center(child: Text("خطأ: ${errorState.message}"));
                    }

                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // تحديث الترجمات عند تغيير اللغة أو عدم وجود ترجمات سابقة
  void _translateTitles(List categories) async {
    if (currentLang == 'en' || translatedTitles.length == categories.length) {
      return;
    }

    List<Future> translationFutures = [];
    Map<int, String> tempTranslations = {};

    try {
      for (int i = 0; i < categories.length; i++) {
        if (!translatedTitles.containsKey(i)) {
          translationFutures.add(
            translator
                .translate(categories[i].name, from: 'en', to: currentLang)
                .then((translated) {
              tempTranslations[i] = translated.text;
            }),
          );
        }
      }

      await Future.wait(translationFutures); // انتظر جميع الترجمات

      setState(() {
        translatedTitles.addAll(tempTranslations);
      });
    } catch (e) {
      print("⚠️ خطأ أثناء الترجمة: $e");
    }
  }

  // تحميل الفئات فقط عند عدم وجود بيانات محملة مسبقًا
  @override
  void initState() {
    super.initState();
    final categoryState = BlocProvider.of<CategoryBloc>(context).state;
    if (categoryState is CategoryInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<CategoryBloc>(context).add(LoadCategoriesEvent());
      });
    }
  }
}
