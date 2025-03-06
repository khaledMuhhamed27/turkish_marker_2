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
  bool hasLoadedData = false; // ✅ لتجنب إعادة تحميل البيانات

  @override
  void initState() {
    super.initState();
    _loadCategoriesOnce(); // ✅ تحميل البيانات مرة واحدة فقط
  }

  void _loadCategoriesOnce() {
    final categoryState = BlocProvider.of<CategoryBloc>(context).state;
    if (categoryState is CategoryInitial && !hasLoadedData) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<CategoryBloc>(context).add(LoadCategoriesEvent());
        hasLoadedData = true; // ✅ عدم إعادة التحميل عند العودة
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color circleColor =
        isDarkMode ? Colors.black26 : Colors.blueGrey.shade50;

    String newLang = context.locale.languageCode;
    if (currentLang != newLang) {
      currentLang = newLang;
      translatedTitles.clear();
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
                      return LoadingWidgt();
                    }

                    if (state is CategoryLoaded) {
                      _translateTitles(state.categories);
                      return ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
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
                    }

                    if (state is CategoryError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("حدث خطأ أثناء تحميل البيانات."),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<CategoryBloc>(context)
                                    .add(LoadCategoriesEvent());
                              },
                              child: Text("إعادة المحاولة"),
                            ),
                          ],
                        ),
                      );
                    }

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("حدث خطأ أثناء تحميل البيانات."),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<CategoryBloc>(context)
                                  .add(LoadCategoriesEvent());
                            },
                            child: Text("إعادة المحاولة"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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

      await Future.wait(translationFutures);

      setState(() {
        translatedTitles.addAll(tempTranslations);
      });
    } catch (e) {
      print("⚠️ خطأ أثناء الترجمة: $e");
    }
  }
}
