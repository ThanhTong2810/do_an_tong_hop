class BillApartment {
  final String maCanHo;
  final String id;
  final String loai_phieuThu;
  final Map noiDung;
  final bool tinhTrang;
  final num tongTien;
  final String ngayLapPhieu;

  BillApartment(
      {this.maCanHo,
      this.id,
      this.loai_phieuThu,
      this.noiDung,
      this.tinhTrang,
      this.tongTien,
      this.ngayLapPhieu});

  BillApartment.fromJson(Map<dynamic, dynamic> json)
      : maCanHo = json['maCanHo'] ?? '',
        id = json['_id'] ?? '',
        loai_phieuThu = json['loai_phieuThu'] ?? '',
        noiDung = json['noiDung'] ?? {},
        tinhTrang = json['tinhTrang']??false,
        tongTien = json['tongTien'] ?? 0,
        ngayLapPhieu = json['ngayLapPhieu']??'';

  Map<dynamic, dynamic> toMap() => {
    'maCanHo': maCanHo ?? '',
    '_id': id ?? '',
    'loai_phieuThu': loai_phieuThu ?? '',
    'noiDung': noiDung ?? {},
    'tinhTrang' : tinhTrang??false,
    'tongTien': tongTien ?? 0,
    'ngayLapPhieu' : ngayLapPhieu??'',
  };
}