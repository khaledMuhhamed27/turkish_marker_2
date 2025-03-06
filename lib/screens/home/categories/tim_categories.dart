import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_bloc.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_event.dart';
import 'package:turkesh_marketer/bloc/categories/bloc/categorries_state.dart';
import 'package:turkesh_marketer/screens/home/categories/category_screen.dart';

class TimCategories extends StatelessWidget {
  const TimCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // إرسال الحدث تلقائيًا عند الدخول إلى الصفحة
    context.read<CategoryBloc>().add(LoadCategoriesEvent());

    return BlocListener<CategoryBloc, CategoryState>(
      listenWhen: (previous, current) => current is CategoryLoaded,
      listener: (context, state) {
        if (state is CategoryLoaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryScreen(key: GlobalKey()),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(child: CircularProgressIndicator()), // شاشة تحميل مؤقتة
      ),
    );
  }
}
