class CommentModel {
  final String content;
  final String idAccount;
  final int timeStamp;
  final String username;
  final String imageSrc;

  CommentModel(this.content, this.idAccount, this.timeStamp, this.username, this.imageSrc);

  CommentModel.fromJson(Map<dynamic, dynamic> json)
      : idAccount = json['id_account'] ?? "",
        content = json['content'] ?? '',
        timeStamp = json['timestamp']??0,
        username = json['username']??'',
        imageSrc = json['imageSrc']??'';

  Map<dynamic, dynamic> toMap() => {
    'id_account': idAccount ?? '',
    'content': content ?? '',
    'timestamp': timeStamp??0,
    'username': username??'',
    'imageSrc': imageSrc??''
  };
}