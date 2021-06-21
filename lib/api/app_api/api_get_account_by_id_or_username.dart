import 'package:dio/dio.dart';
import 'package:do_an_tong_hop/api/api_response.dart';
import 'package:do_an_tong_hop/api/do_an_api.dart';


class GetAccountByIdOrUserNameApi extends DoAnApi {
  GetAccountByIdOrUserNameApi() : super();

  Future<ApiResponse> getAccountByIdOrUserNameApi({String id, String userName}) async {
    var dataSend = {
      "id": id,
      "username": userName??null
    };
    dataSend.removeWhere((key, value) => value == null);
    ApiResponse apiResponse;
    try {
      Response response = await DoAnApi.httpClient.get(
        DoAnApi.GET_ACCOUNT_BY_ID,
        queryParameters: dataSend,
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
