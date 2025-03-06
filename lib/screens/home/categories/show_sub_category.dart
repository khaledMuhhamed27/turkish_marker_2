import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_state.dart';
import 'package:turkesh_marketer/model/categories_modell.dart';
import 'package:turkesh_marketer/screens/home/categories/show_select_categories.dart';
import 'package:turkesh_marketer/screens/home/categories/tim_categories.dart';
import 'package:turkesh_marketer/widgets/appbar.dart';

class ShowSubCategoryScrren extends StatelessWidget {
  final Category category;

  const ShowSubCategoryScrren({
    super.key,
    required this.category,
  });

  final String baseUrl = "https://turkish.weblayer.info/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: CustomAppBar(
              myLiftIcon: Icons.arrow_back,
              onLeftIconTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimCategories()),
                );
              },
              onRightIconTap: () {
                Navigator.pushNamed(context, 'search');
              },
              myRightButton: true,
              titleScreen: category.name,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: BlocListener<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryLoading) {
                } else if (state is CategoryError) {
                } else {}
              },
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SubcategoriesLoaded) {
                    print("🟢 البيانات التي ستُعرض: ${state.subcategories}");

                    if (state.subcategories.isEmpty) {
                      return Center(child: Text("لا توجد فئات فرعية متاحة"));
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: state.subcategories.length,
                      itemBuilder: (context, index) {
                        final subcategory = state.subcategories[index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowSelectCategories(
                                  importModel: subcategory.parentId.toString(),
                                ),
                              ),
                            );
                            print(
                                "Parent_id=${subcategory.parentId.toString()}");
                          },
                          title: Text(subcategory.name),
                          subtitle: Text(subcategory.description),
                        );
                      },
                    );
                  } else if (state is CategoryError) {
                    return Center(child: Text("خطأ: ${state.message}"));
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
