import 'package:do_an_tong_hop/api/api_response.dart';
import 'package:do_an_tong_hop/api/app_api/apartment/api_get_bill_apartment.dart';
import 'package:do_an_tong_hop/api/app_api/apartment/api_get_cost_apartment.dart';
import 'package:do_an_tong_hop/api/app_api/apartment/api_get_post_apartment.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/apartment/bill_apartment.dart';
import 'package:do_an_tong_hop/models/apartment/cost_apartment.dart';
import 'package:do_an_tong_hop/models/apartment/post_apartment.dart';
import 'package:get/get.dart';

class ApartmentController extends GetxController{
  RxList<PostApartment> postsApartment = RxList<PostApartment>([]);
  RxList<CostApartment> costsApartment = RxList<CostApartment>([]);
  RxList<BillApartment> billsApartment = RxList<BillApartment>([]);

  getPostsApartment() async{
    ApiResponse response =
    await GetPostApartmentApi().getPostApartmentApi();
    List posts = response.data??[];
    postsApartment.assignAll(posts.map((e) => PostApartment.fromJson(e)).toList());
    postsApartment.sort((a,b)=>b.ngayDang.compareTo(a.ngayDang));
  }

  getBillsApartment(UserController userController) async{
    ApiResponse response =
    await GetBillApartmentApi().getBillApartmentApi(id: userController.user.value.id);
    List bills = response.data??[];
    billsApartment.assignAll(bills.map((e) => BillApartment.fromJson(e)).toList());
  }

  getCostsApartment() async{
    ApiResponse response =
    await GetCostApartmentApi().getCostApartmentApi();
    List costs = response.data;
    costsApartment.assignAll(costs.map((e) => CostApartment.fromJson(e)).toList());
  }
}