class PostApartment {
  final List<dynamic> hinhAnh;
  final String theLoai;
  final String noiDung;
  final num ngayDang;
  final num v;
  final String username;
  final String noiDung2;

  PostApartment(
      {this.hinhAnh,
      this.theLoai,
      this.noiDung,
      this.ngayDang,
      this.v,
        this.username,
      this.noiDung2});


  PostApartment.fromJson(Map<dynamic, dynamic> json)
      : hinhAnh = json['hinhAnh'] ?? '',
        theLoai = json['theLoai'] ?? '',
        noiDung = json['noiDung'] ?? '',
        ngayDang = json['ngayDang'] ?? 0,
        noiDung2 = json['noiDung2']??"",
        username = json['username']??'',
        v = json['__v'] ?? 0;

  Map<dynamic, dynamic> toMap() => {
    'hinhAnh': hinhAnh ?? '',
    'theLoai': theLoai ?? '',
    'noiDung': noiDung ?? '',
    'ngayDang': ngayDang ?? 0,
    'noiDung2' : noiDung2??"",
    'v': v ?? 0,
    'username': username??''
  };
}