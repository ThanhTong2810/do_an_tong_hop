import 'dart:convert';

import 'package:do_an_tong_hop/models/posts_model/comment_model.dart';

class PostsModel {
  final String content;
  final String idAccount;
  final String idPost;
  final List<dynamic> imageSrc;
  final int timeStamp;
  List<CommentModel> comments;

  PostsModel(this.content, this.idAccount, this.idPost, this.imageSrc, this.timeStamp, this.comments);

  PostsModel.fromJson(Map<dynamic, dynamic> json)
      : idAccount = json['id_account'] ?? "",
        idPost = json['id_post'] ?? '',
        imageSrc = json['imageSrc'] ?? [],
        content = json['content'] ?? '',
        timeStamp = json['timestamp']??0,
        comments = (json['comments'] as List ?? []).map((e) => CommentModel.fromJson(e)).toList();
  Map<dynamic, dynamic> toMap() => {
    'id_account': idAccount ?? '',
    'id_post': idPost ?? '',
    'content': content ?? '',
    'imageSrc': imageSrc ?? [],
    'timestamp': timeStamp??0,
    'comments':comments.map((e) => e.toMap()).toList()??[]
  };

  static getListCommentModel(List<dynamic> comments){
    List<CommentModel> commentsModel = [];
    for(var comment in comments){
      if(comment.runtimeType.toString()=='List<dynamic>'){
        comment.map((object)=>commentsModel.add(CommentModel.fromJson(object))).toList();
      }else{
        commentsModel.add(CommentModel.fromJson(comment));
      }
    }
    return commentsModel;
  }
}