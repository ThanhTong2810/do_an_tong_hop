class User{
  final String id;
  final String email;
  final String password;
  final String imgSrc;
  final String userName;
  final String name;
  final String description;
  final List<UserFollow> followers ;
  final List<UserFollow> following;
  final bool isLogin;

  User(this.id, this.email, this.password, this.imgSrc, this.userName, this.name, this.description, this.followers, this.following, this.isLogin);

  User.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'] ?? "",
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        imgSrc = json['imageSrc'] ?? "",
        userName = json['username'] ?? '',
        name = json['name'] ?? '',
        description = json['description'] ?? '',
        followers = (json['followers'] as List ??[]).map((e) => UserFollow.fromJson(e)).toList(),
        following = (json['following'] as List ??[]).map((e) => UserFollow.fromJson(e)).toList(),
        isLogin = json['isLogin']??false;

  Map<dynamic, dynamic> toMap() => {
    'id': id ?? '',
    'email': email ?? '',
    'password': password ?? '',
    'imgSrc': imgSrc ?? '',
    'userName': userName ?? '',
    'name': name ?? '',
    'description': description ?? '',
    'followers': followers.map((e) => e.toMap()).toList() ?? [],
    'following': following.map((e) => e.toMap()).toList() ?? [],
    'isLogin' : isLogin??false
  };
}

class UserFollow{
  final String id;
  final String idAccount;
  final String name;
  final String imageSrc;
  final String username;
  final String email;

  UserFollow(this.id, this.idAccount, this.name, this.imageSrc, this.username, this.email);

  UserFollow.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'] ?? '',
        idAccount = json['id_account'] ?? '',
        name = json['name'] ?? '',
        imageSrc = json['imageSrc'] ?? '',
        username = json['username'] ?? '',
        email = json['email'] ?? '';

  Map<dynamic, dynamic> toMap() => {
    'id': id ?? '',
    'id_account': idAccount ?? '',
    'name': name ?? '',
    'imageSrc': imageSrc ?? '',
    'username': username ?? '',
    'email': email ?? '',
  };
}