import 'package:dio/dio.dart';

class DoAnApi {
  static const BASE_URL = "https://baby-dont-cry.herokuapp.com/";

  /// URLs POSTER
  static const POST_USER_SIGN_IN = 'user/signIn';
  static const POST_USER_SIGN_UP = 'user/signUp';
  static const GET_ACCOUNT_BY_ID = 'user';
  static const PUT_UPDATE_AVATAR = 'user';
  static const POST_FOLLOW_ACCOUNT = 'user/follow';
  static const DELETE_UNFOLLOW_ACCOUNT = 'user/follow';
  static const GET_SUGGESTED_ACCOUNT_BY_ID = 'user/suggestedAccounts';
  static const PUT_LOG_OUT = 'user/signIn';
  static const GET_POSTS = 'post';
  static const POST_SAVE_POSTS = 'post';
  static const POST_COMMENT = 'post/comment';
  static const REPLY_COMMENT = 'post/replyComment';
  static const POST_LIKE = 'post/like';
  static const GET_POSTS_BY_ID= 'post/byId';
  static const GET_POST_APARTMENT = 'apt/getPost';
  static const GET_BILL_APARTMENT = 'apt/getBill';
  static const GET_COST_APARTMENT = 'apt/getCost';

  /// HEADERS
  static const CONTENT_TYPE = 'Content-Type';
  static const CONTENT_TYPE_JSON = 'application/json; charset=utf-8';
  static const AUTHORIZATION = 'Authorization';

  /// Response Keys
  static const KEY_RESULTS = 'results';
  static const KEY_ERROR = 'error';

  /// Http status code
  static const HTTP_STATUS_CODE_SUCCESS_200 = 200;
  static const HTTP_STATUS_CODE_SUCCESS_201 = 201;
  static const HTTP_STATUS_CODE_SUCCESS_202 = 202;
  static const HTTP_STATUS_CODE_ERROR = 403;

  static Dio httpClient;

  DoAnApi() {
    if (httpClient == null) {
      Map<String, dynamic> headers = Map();
      headers.putIfAbsent(CONTENT_TYPE, () => CONTENT_TYPE_JSON);
      BaseOptions options = new BaseOptions(
          baseUrl: BASE_URL,
          connectTimeout: 20000,
          receiveTimeout: 20000,
          headers: headers);
      DoAnApi.httpClient = Dio(options);
    }
  }
}
