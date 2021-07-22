class ChatMessages {
  final String content;
  final String idUser;
  final String name;
  final int time;
  final List<dynamic> image;
  final String imageSender;
  final String userName;

  ChatMessages(this.content, this.idUser, this.name, this.time, this.imageSender, this.userName, this.image);


  ChatMessages.fromJson(Map<dynamic, dynamic> json)
      : content = json['content'] ?? '',
        idUser = json['idUser'] ?? '',
        name = json['name'] ?? '',
        time = json['time'] ?? 0,
        imageSender = json['imageSender']??"",
        image = json['image']??[],
        userName = json['userName'] ?? '';

  Map<dynamic, dynamic> toMap() => {
    'content': content ?? '',
    'idUser': idUser ?? '',
    'name': name ?? '',
    'time': time ?? 0,
    'imageSender' : imageSender??"",
    'image': image??[],
    'userName': userName ?? ''
  };
}