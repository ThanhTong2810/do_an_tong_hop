class ChatMessages {
  final String content;
  final String idUser;
  final String name;
  final int time;
  final String userName;

  ChatMessages(this.content, this.idUser, this.name, this.time, this.userName);


  ChatMessages.fromJson(Map<dynamic, dynamic> json)
      : content = json['content'] ?? '',
        idUser = json['idUser'] ?? '',
        name = json['name'] ?? '',
        time = json['time'] ?? 0,
        userName = json['userName'] ?? '';

  Map<dynamic, dynamic> toMap() => {
    'content': content ?? '',
    'idUser': idUser ?? '',
    'name': name ?? '',
    'time': time ?? 0,
    'userName': userName ?? ''
  };
}