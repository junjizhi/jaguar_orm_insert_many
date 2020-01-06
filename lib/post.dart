import 'package:flutter_jaguar_orm/user.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'post.jorm.dart';

class Post {
  @PrimaryKey()
  int id;

  String title;

  @BelongsTo(UserBean)
  int userId;

  static const String tableName = '_post';

  String toString() => "Post($id, $title)";
}

@GenBean()
class PostBean extends Bean<Post> with _PostBean {
  @override
  final String tableName = 'posts';

  UserBean _userBean;

  @override
  UserBean get userBean => _userBean ??= new UserBean(adapter);

  PostBean(Adapter adapter) : super(adapter);
}