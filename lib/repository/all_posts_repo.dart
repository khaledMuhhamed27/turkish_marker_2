import 'package:turkesh_marketer/api/show_select_categ_service.dart';
import 'package:turkesh_marketer/model/show_select_categ_model.dart';

class PostRepository {
  final PostService _postService;

  PostRepository(this._postService);

  // دالة لجلب البوستات حسب parent_id
  Future<List<Post>> fetchPostsByParentId(String parentId) {
    return _postService.fetchPostsByParentId(parentId);
  }
}
