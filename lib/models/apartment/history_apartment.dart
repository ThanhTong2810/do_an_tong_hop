class HistoryApartment {
  final String maCanHo;
  final String id;
  final String loai_phieuThu;
  final bool tinhTrang;
  final num tongTien;
  final num ngayThanhToan;

  HistoryApartment(
      {this.maCanHo,
        this.id,
        this.loai_phieuThu,
        this.tinhTrang,
        this.tongTien,
        this.ngayThanhToan});

  HistoryApartment.fromJson(Map<dynamic, dynamic> json)
      : maCanHo = json['maCanHo'] ?? '',
        id = json['_id'] ?? '',
        loai_phieuThu = json['loai_phieuThu'] ?? '',
        tinhTrang = json['tinhTrang']??false,
        tongTien = json['tongTien'] ?? 0,
        ngayThanhToan = json['ngayThanhToan']??0;

  Map<dynamic, dynamic> toMap() => {
    'maCanHo': maCanHo ?? '',
    '_id': id ?? '',
    'loai_phieuThu': loai_phieuThu ?? '',
    'tinhTrang' : tinhTrang??false,
    'tongTien': tongTien ?? 0,
    'ngayThanhToan' : ngayThanhToan??0,
  };
}