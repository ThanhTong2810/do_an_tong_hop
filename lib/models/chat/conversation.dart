
import 'package:do_an_tong_hop/models/user/user.dart';

class Conversation {

  User user;

  bool isActive;

  DateTime lastActive;

  Conversation({
     this.user,  this.isActive,  this.lastActive
  });

}