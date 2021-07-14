import 'package:do_an_tong_hop/controller/apartment_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryApartmentScreen extends StatefulWidget {
  const HistoryApartmentScreen({Key key}) : super(key: key);

  @override
  _HistoryApartmentScreenState createState() => _HistoryApartmentScreenState();
}

class _HistoryApartmentScreenState extends State<HistoryApartmentScreen> {
  final ApartmentController apartmentController = Get.find();
  final UserController userController = Get.find();

  @override
  void initState() {
    loadHistory();
    super.initState();
  }

  loadHistory() async{
    await apartmentController.getHistoryApartment(userController);
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: AppText(
            color: AppColors.black,
            text: 'History Apartment',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: apartmentController.historyApartment.map((history){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      _buildRowHistory('Mã Căn Hộ:', history.maCanHo),
                      Dimens.height10,
                      _buildRowHistory('Loại Phiếu:', history.loai_phieuThu),
                      Dimens.height10,
                      _buildRowHistory('Tổng Tiền:', '${history.tongTien} vnd'),
                      Dimens.height10,
                      _buildRowHistory('Tình Trạng:', history.tinhTrang == true ? 'Đã Thanh Toán':'Chưa Thanh Toán'),
                      Dimens.height10,
                      _buildRowHistory('Ngày Thanh Toán:', '${formatBillDateTime(DateTime.fromMillisecondsSinceEpoch(history.ngayThanhToan))}'),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildRowHistory(String title, String content){
    return Row(
      children: <Widget>[
        AppText(
          text: title,
          color: AppColors.black,
        ),
        Dimens.width10,
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
