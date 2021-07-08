class Notify{
  final bool hasSeen;
  final String idAccount;
  final String idPost;
  final bool isShow;
  final String message;
  final num timestamp;
  final String type;
  final String imageSrc;
  final String username;

  Notify({this.imageSrc,
    this.username,
      this.hasSeen,
      this.idAccount,
      this.idPost,
      this.isShow,
      this.message,
      this.timestamp,
      this.type});

  Notify.fromJson(Map<dynamic, dynamic> json)
      : hasSeen = json['hasSeen'] ?? false,
        idAccount = json['id_account'] ?? '',
        idPost = json['id_post'] ?? '',
        isShow = json['isShow'] ?? true,
        message = json['message'] ?? '',
        timestamp = json['timestamp'] ?? 0,
        type = json['type'] ?? '',
        imageSrc = json['imageSrc']??'',
        username = json['username']??'';

  Map<dynamic, dynamic> toMap() => {
    'hasSeen': hasSeen ?? false,
    'id_account': idAccount ?? '',
    'id_post': idPost ?? '',
    'isShow': isShow ?? true,
    'message': message ?? '',
    'timestamp': timestamp ?? 0,
    'type': type ?? '',
    'imageSrc': imageSrc??'',
    'username':username??'',
  };
}