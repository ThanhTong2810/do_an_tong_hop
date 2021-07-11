class CostApartment {
  final String id;
  final String maChiPhi;
  final String tenLoaiChiPhi;
  final num giaTien;
  final num v;

  CostApartment(
      {this.id, this.maChiPhi, this.tenLoaiChiPhi, this.giaTien, this.v});


  CostApartment.fromJson(Map<dynamic, dynamic> json)
      : id = json['_id'] ?? '',
        maChiPhi = json['maChiPhi'] ?? '',
        tenLoaiChiPhi = json['tenLoaiChiPhi'] ?? '',
        giaTien = json['giaTien'] ?? 0,
        v = json['__v']??0;

  Map<dynamic, dynamic> toMap() => {
    '_id': id ?? '',
    'maChiPhi': maChiPhi ?? '',
    'tenLoaiChiPhi': tenLoaiChiPhi ?? '',
    'giaTien': giaTien ?? 0,
    '__v' : v??0,
  };
}