import 'package:dio/dio.dart';
import 'package:do_an_tong_hop/api/api_response.dart';
import 'package:do_an_tong_hop/api/do_an_api.dart';


class SignUpApi extends DoAnApi {
  SignUpApi() : super();

  Future<ApiResponse> signUpApi({String email, String password, String userName,String name, String description}) async {
    var dataSend = {
      "email": email,
      "password": password,
      "username": userName,
      "name": name,
      "description": description,
    };
    ApiResponse apiResponse;
    try {
      Response response = await DoAnApi.httpClient.post(
        DoAnApi.POST_USER_SIGN_UP,
        data: dataSend,
      );
      final data = response.data;
      apiResponse = ApiResponse(data: data, apiError: null);
      if (response.statusCode == DoAnApi.HTTP_STATUS_CODE_SUCCESS_200 ||
          response.statusCode == DoAnApi.HTTP_STATUS_CODE_SUCCESS_201) {
        final data = response.data;
        apiResponse = ApiResponse(data: data, apiError: null);
      }
      return apiResponse;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.message);
      }
      return ApiResponse(
        data: null,
        apiError: ApiError(e.response.statusCode, e.response.statusMessage)
      );
    }
  }
}