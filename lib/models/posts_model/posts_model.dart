import 'dart:convert';

import 'package:do_an_tong_hop/models/posts_model/comment_model.dart';

class PostsModel {
  final String content;
  final String idAccount;
  final String idPost;
  final List<dynamic> imageSrc;
  final int timeStamp;
  final num comments;
  final String username;
  final String accountImage;
  final Map like;

  PostsModel(
      {this.content,
      this.idAccount,
      this.idPost,
      this.imageSrc,
      this.timeStamp,
      this.comments,
      this.username,
      this.accountImage,
      this.like});

  PostsModel.fromJson(Map<dynamic, dynamic> json)
      : idAccount = json['id_account'] ?? "",
        idPost = json['id_post'] ?? '',
        imageSrc = json['imageSrc'] ?? [],
        content = json['content'] ?? '',
        timeStamp = json['timestamp']??0,
        comments = json['comments']??0,
        username = json['username']??'',
        accountImage = json['accountImage']??'',
        like= json['likes']??{};
  Map<dynamic, dynamic> toMap() => {
    'id_account': idAccount ?? '',
    'id_post': idPost ?? '',
    'content': content ?? '',
    'imageSrc': imageSrc ?? [],
    'timestamp': timeStamp??0,
    'comments':comments??0,
    'username': username??'',
    "accountImage": accountImage??'',
    'likes': like??{}
  };
}