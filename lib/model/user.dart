class User {
  bool admin;
  List<Object> chapterTops;
  List<Object> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String token;
  int type;
  String username;

  User.fromMap(Map<String, dynamic> map) {
    admin = map['admin'];
    chapterTops = map['chapterTops'];
    collectIds = map['collectIds'];
    email = map['email'];
    icon = map['icon'];
    id = map['id'];
    nickname = map['nickname'];
    password = map['password'];
    token = map['token'];
    type = map['type'];
    username = map['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map();
    map['admin'] = admin;
    map['chapterTops'] = chapterTops;
    map['collectIds'] = collectIds;
    map['email'] = email;
    map['icon'] = icon;
    map['id'] = id;
    map['nickname'] = nickname;
    map['password'] = password;
    map['token'] = token;
    map['type'] = type;
    map['username'] = username;
    return map;
  }
}
