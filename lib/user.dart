import 'package:flutter_jaguar_orm/post.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'user.jorm.dart';

class User {
  @PrimaryKey()
  int id;

  String name;

  User({this.id, this.name});

  @HasMany(PostBean)
  List<Post> posts;

  static const String tableName = '_user';

  String toString() => "User($id, $name)";
}

@GenBean()
class UserBean extends Bean<User> with _UserBean {
  @override
  final String tableName = 'users';

  @override
  final PostBean postBean;

  UserBean(Adapter adapter)
      : postBean = PostBean(adapter),
        super(adapter);
}