import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/select_categories.dart/bloc/select_posts_event.dart';
import 'package:turkesh_marketer/bloc/bloc/select_categories.dart/bloc/select_posts_state.dart';
import 'package:turkesh_marketer/model/show_select_categ_model.dart';
import 'package:turkesh_marketer/repository/all_posts_repo.dart';

class PostBloc extends Bloc<SelectPostsEvent, SelectPostsState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(SelectPostsInitial()) {
    on<LoadPostsEvent>((event, emit) async {
      emit(LoadingPostsState()); // عندما يبدأ التحميل
      try {
        // جلب البيانات من الـ repository باستخدام parentId
        List<Post> posts =
            await postRepository.fetchPostsByParentId(event.parentId);
        emit(LoadedPostsState(posts)); // عند إتمام التحميل
      } catch (e) {
        // عند حدوث خطأ في تحميل البيانات
        print("⚠️ خطأ أثناء تحميل البيانات: $e"); // طباعة الخطأ لتتبع المشكلة
        emit(ErrorPostsState(
            "حدث خطأ أثناء تحميل البيانات")); // عرض رسالة الخطأ في واجهة المستخدم
      }
    });
  }
}
