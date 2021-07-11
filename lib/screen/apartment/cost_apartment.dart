import 'package:do_an_tong_hop/controller/apartment_controller.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CostApartmentScreen extends StatefulWidget {
  const CostApartmentScreen({Key key}) : super(key: key);

  @override
  _CostApartmentScreenState createState() => _CostApartmentScreenState();
}

class _CostApartmentScreenState extends State<CostApartmentScreen> {
  final ApartmentController apartmentController = Get.find();

  @override
  void initState() {
    onWidgetBuildDone(getCostsApartment);
    super.initState();
  }

  getCostsApartment() async{
    await apartmentController.getCostsApartment();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: AppText(
            text: 'Cost Apartment',
            color: AppColors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: apartmentController.costsApartment.map((cost){
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildTitleContentCard('ID:', cost.id),
                        Dimens.height10,
                        _buildTitleContentCard('Mã Chi Phí:', cost.maChiPhi),
                        Dimens.height10,
                        _buildTitleContentCard('Tên Chi Phí:', cost.tenLoaiChiPhi),
                        Dimens.height10,
                        _buildTitleContentCard('Giá Tiền', '${cost.giaTien}'),
                        Dimens.height10,
                        _buildTitleContentCard('__V:', '${cost.v}'),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildTitleContentCard(String title, String content){
    return Row(
      children: <Widget>[
        Container(
          width: getScreenWidth(context)/4,
          child: AppText(
            text: title,
            color: AppColors.black,
          ),
        ),
        Dimens.width20,
        Expanded(
          child: AppText(
            text: content,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
