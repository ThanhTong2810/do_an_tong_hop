class CommentModel {
  final String id;
  final String content;
  final String idAccount;
  final int timeStamp;
  final String username;
  final String accountImage;
  final List<ReplyModel> reply;

  CommentModel(this.id, this.content, this.idAccount, this.timeStamp, this.username, this.accountImage, this.reply);

  CommentModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['id']??'',
        idAccount = json['id_account'] ?? "",
        content = json['content'] ?? '',
        timeStamp = json['timestamp']??0,
        username = json['username']??'',
        accountImage = json['accountImage']??'',
        reply = (json['reply'] as List ?? []).map((e) => ReplyModel.fromJson(e)).toList();

  Map<dynamic, dynamic> toMap() => {
    "id":id??'',
    'id_account': idAccount ?? '',
    'content': content ?? '',
    'timestamp': timeStamp??0,
    'username': username??'',
    'accountImage': accountImage??'',
    'reply':reply.map((e) => e.toMap()).toList()??[]
  };
}

class ReplyModel {
  final String content;
  final String idAccount;
  final int timeStamp;
  final String username;
  final String accountImage;
  final String id;

  ReplyModel(this.content, this.idAccount, this.timeStamp, this.username, this.accountImage, this.id);

  ReplyModel.fromJson(Map<dynamic, dynamic> json)
      : idAccount = json['id_account'] ?? "",
        content = json['content'] ?? '',
        timeStamp = json['timestamp']??0,
        username = json['username']??'',
        accountImage = json['accountImage']??'',
        id = json['id']??'';

  Map<dynamic, dynamic> toMap() => {
    'id_account': idAccount ?? '',
    'content': content ?? '',
    'timestamp': timeStamp??0,
    'username': username??'',
    'accountImage': accountImage??'',
    "id":id??''
  };
}