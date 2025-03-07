import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/select_categories.dart/bloc/select_posts_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/select_categories.dart/bloc/select_posts_event.dart';
import 'package:turkesh_marketer/bloc/bloc/select_categories.dart/bloc/select_posts_state.dart';
import 'package:turkesh_marketer/widgets/loading_widgt.dart';
import 'package:turkesh_marketer/widgets/my_card_list.dart';

class ShowSelectCategories extends StatelessWidget {
  final String importModel;

  const ShowSelectCategories({super.key, required this.importModel});

  @override
  Widget build(BuildContext context) {
    // إطلاق الحدث مباشرة عند الدخول إلى الصفحة
    BlocProvider.of<PostBloc>(context)
        .add(LoadPostsEvent(parentId: importModel));

    return Scaffold(
      appBar: AppBar(
        title: Text("البوستات المتعلقة بالفئة"),
      ),
      body: BlocListener<PostBloc, SelectPostsState>(
        listener: (context, state) {
          // يمكن إضافة تحكمات مثل رسائل الخطأ أو النجاح هنا
          if (state is ErrorPostsState) {
            // رسالة عند الخطأ، مثل ظهور تنبيه
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<PostBloc, SelectPostsState>(
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return LoadingWidgt();
            }

            if (state is LoadedPostsState) {
              final posts = state.posts;

              // تحقق من طول القائمة وإذا كانت فارغة، قم بإظهار رسالة مناسبة
              if (posts.isEmpty) {
                return Center(child: Text("لا توجد بوستات لعرضها"));
              }

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return MyCardList(
                    id: post.id,
                    title: post.title,
                    credits: post.credit,
                    createdAt: post.createdAt.toString(),
                    imageUrl: post.photo,
                    details: post.details,
                    onTap: () {
                      // هنا يمكن إضافة صفحة التفاصيل إذا رغبت بذلك
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         ShowDetailsScreen(tender: post),
                      //   ),
                      // );
                    },
                  );
                },
              );
            }

            if (state is ErrorPostsState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // إعادة تحميل البيانات عند حدوث خطأ
                        BlocProvider.of<PostBloc>(context)
                            .add(LoadPostsEvent(parentId: importModel));
                      },
                      child: Text("إعادة المحاولة"),
                    ),
                  ],
                ),
              );
            }

            return SizedBox(); // في حالة غير ذلك لا شيء يعرض
          },
        ),
      ),
    );
  }
}
