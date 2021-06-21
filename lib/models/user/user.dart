class User{
  final String id;
  final String email;
  final String password;
  final String imgSrc;
  final String userName;
  final String name;
  final String description;
  final Map followers ;
  final Map following;
  final bool isLogin;

  User(this.id, this.email, this.password, this.imgSrc, this.userName, this.name, this.description, this.followers, this.following, this.isLogin);

  User.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'] ?? -1,
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        imgSrc = json['imageSrc'] ?? "",
        userName = json['username'] ?? '',
        name = json['name'] ?? '',
        description = json['description'] ?? '',
        followers = json['followers']??{},
        following = json['following']??{},
        isLogin = json['isLogin']??false;

  Map<dynamic, dynamic> toMap() => {
    'id': id ?? '',
    'email': email ?? '',
    'password': password ?? '',
    'imgSrc': imgSrc ?? '',
    'userName': userName ?? '',
    'name': name ?? '',
    'description': description ?? '',
    'followers': followers,
    'following': following,
    'isLogin' : isLogin??false
  };
}

class Followers{
  final String id;

  Followers(this.id);

  Followers.fromJson(Map<dynamic, dynamic> json)
      : id = json['id_account'] ?? '';

  Map<dynamic, dynamic> toMap() => {
    'id_account': id ?? ''
  };
}

class Following{
  final String id;

  Following(this.id);

  Following.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'] ?? '';

  Map<dynamic, dynamic> toMap() => {
    'id': id ?? ''
  };
}