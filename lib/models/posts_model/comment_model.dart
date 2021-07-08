class CommentModel {
  final String id;
  final String content;
  final String idAccount;
  final int timeStamp;
  final Map reply;

  CommentModel(this.content, this.idAccount, this.timeStamp, this.reply, this.id);

  CommentModel.fromJson(Map<dynamic, dynamic> json,  this.id)
      : idAccount = json['id_account'] ?? "",
        content = json['content'] ?? '',
        timeStamp = json['timestamp']??0,
        reply = json['reply'] ?? {};

  Map<dynamic, dynamic> toMap() => {
    'id_account': idAccount ?? '',
    'content': content ?? '',
    'timestamp': timeStamp??0,
    'reply':reply??{}
  };
}

class ReplyModel {
  final String id;
  final String content;
  final String idAccount;
  final int timeStamp;

  ReplyModel(this.content, this.idAccount, this.timeStamp, this.id);

  ReplyModel.fromJson(Map<dynamic, dynamic> json, this.id)
      : idAccount = json['id_account'] ?? "",
        content = json['content'] ?? '',
        timeStamp = json['timestamp']??0;

  Map<dynamic, dynamic> toMap() => {
    'id_account': idAccount ?? '',
    'content': content ?? '',
    'timestamp': timeStamp??0,
  };
}