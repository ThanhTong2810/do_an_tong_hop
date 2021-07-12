import 'package:do_an_tong_hop/controller/apartment_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/apartment/bill_apartment.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillApartmentScreen extends StatefulWidget {
  const BillApartmentScreen({Key key}) : super(key: key);

  @override
  _BillApartmentScreenState createState() => _BillApartmentScreenState();
}

class _BillApartmentScreenState extends State<BillApartmentScreen> {
  final ApartmentController apartmentController = Get.find();
  final UserController userController = Get.find();

  @override
  void initState() {
    onWidgetBuildDone(getBillsApartment);
    super.initState();
  }

  getBillsApartment() async{
    await apartmentController.getBillsApartment(userController);
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: AppText(
            text: 'Bill Apartment',
            color: AppColors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: apartmentController.billsApartment.map((bill){
              return getBill(bill.loai_phieuThu.toString(), bill);
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget getBill(String loai, BillApartment bill){
    switch(loai){
      case 'service_fee':
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: AppText(
                      text: 'Chi tiết quản lý căn hộ',
                      color: AppColors.black,
                    ),
                  ),
                  _buildTitleContentCard('Căn hộ: ', bill.maCanHo),
                  Dimens.height10,
                  _buildTitleContentCard('Ngày lập phiếu: ', '${formatBillDateTime(DateTime.tryParse(bill.ngayLapPhieu))}'),
                  Dimens.height10,
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.symmetric(outside: BorderSide(width: 1)),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Diện tích',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'DVT',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Đơn giá',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Thành tiền',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: '${bill.noiDung['dienTich']}',
                              color: AppColors.black,
                              textSize: Dimens.paragraphTextSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'm2',
                              color: AppColors.black,
                              textSize: Dimens.paragraphTextSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: '7000 vnd',
                              color: AppColors.black,
                              textSize: Dimens.paragraphTextSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: '${bill.tongTien}',
                              color: AppColors.black,
                              textSize: Dimens.paragraphTextSize,
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Dimens.height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: AppText(
                          text: 'Tổng tiền:',
                          color: AppColors.black,
                        ),
                      ),
                      Center(
                        child: AppText(
                          text: '${bill.tongTien} vnd',
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  Dimens.height10,
                ],
              ),
            ),
          ),
        );
      case 'water_fee':
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: AppText(
                      text: 'Chi tiết phiếu thu tiền nước',
                      color: AppColors.black,
                    ),
                  ),
                  _buildTitleContentCard('Căn hộ: ', bill.maCanHo),
                  Dimens.height10,
                  _buildTitleContentCard('Ngày lập phiếu: ', '${formatBillDateTime(DateTime.tryParse(bill.ngayLapPhieu))}'),
                  Dimens.height10,
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.symmetric(outside: BorderSide(width: 1)),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Chỉ số mới',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Chỉ số cũ',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Tiêu thụ',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['chiSoMoi']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['chiSoCu']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['tieuThu']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Center(
                          child: AppText(
                            text: 'Định mức 1',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['dinhMuc1']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['tienDinhMuc1']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Center(
                          child: AppText(
                            text: 'Định mức 2',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['dinhMuc2']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['tienDinhMuc2']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Định mức 3',
                              color: AppColors.black,
                              textSize: Dimens.paragraphTextSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: '${bill.noiDung['dinhMuc3']}',
                              color: AppColors.black,
                              textSize: Dimens.paragraphTextSize,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: '${bill.noiDung['tienDinhMuc3']}',
                              color: AppColors.black,
                              textSize: Dimens.paragraphTextSize,
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Dimens.height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: AppText(
                          text: 'Tổng tiền:',
                          color: AppColors.black,
                        ),
                      ),
                      Center(
                        child: AppText(
                          text: '${bill.tongTien} vnd',
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  Dimens.height10,
                ],
              ),
            ),
          ),
        );
      case 'parking_fee':
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: AppText(
                      text: 'Chi tiết phiếu thu tiền giữ xe',
                      color: AppColors.black,
                    ),
                  ),
                  _buildTitleContentCard('Căn hộ: ', bill.maCanHo),
                  Dimens.height10,
                  _buildTitleContentCard('Ngày lập phiếu: ', '${formatBillDateTime(DateTime.tryParse(bill.ngayLapPhieu))}'),
                  Dimens.height10,
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.symmetric(outside: BorderSide(width: 1)),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Loại xe',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Số lượng',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Đơn giá',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Thành tiền',
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Center(
                          child: AppText(
                            text: 'Xe ôtô',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['oto']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '200000 vnd',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['tienOto']}',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Center(
                          child: AppText(
                            text: 'Xe máy',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['xeMay']}',
                            textSize: Dimens.paragraphTextSize,
                            color: AppColors.black,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '20000 vnd',
                            color: AppColors.black,
                            textSize: Dimens.paragraphTextSize,
                          ),
                        ),
                        Center(
                          child: AppText(
                            text: '${bill.noiDung['tienXeMay']}',
                            textSize: Dimens.paragraphTextSize,
                            color: AppColors.black,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: 'Xe đạp',
                              textSize: Dimens.paragraphTextSize,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: '${bill.noiDung['xeDap']}',
                              textSize: Dimens.paragraphTextSize,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: '10000 vnd',
                              textSize: Dimens.paragraphTextSize,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: AppText(
                              text: '${bill.noiDung['tienXeDap']}',
                              textSize: Dimens.paragraphTextSize,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Dimens.height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: AppText(
                          text: 'Tổng tiền:',
                          color: AppColors.black,
                        ),
                      ),
                      Center(
                        child: AppText(
                          text: '${bill.tongTien} vnd',
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  Dimens.height10,
                ],
              ),
            ),
          ),
        );
      default:
        return SizedBox();
    }
  }

  Widget _buildTitleContentCard(String title, String content){
    return Row(
      children: <Widget>[
        Expanded(
          child: AppText(
            text: title,
            color: AppColors.black,
          ),
        ),
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
