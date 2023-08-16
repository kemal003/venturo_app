class Menu {
  int? statusCode;
  List<Datas>? datas;

  Menu({this.statusCode, this.datas});

  Menu.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['datas'] != null) {
      datas = <Datas>[];
      json['datas'].forEach((v) {
        datas!.add(new Datas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.datas != null) {
      data['datas'] = this.datas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  int? id;
  String? nama;
  int? harga;
  String? tipe;
  String? gambar;

  Datas({this.id, this.nama, this.harga, this.tipe, this.gambar});

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    harga = json['harga'];
    tipe = json['tipe'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['harga'] = this.harga;
    data['tipe'] = this.tipe;
    data['gambar'] = this.gambar;
    return data;
  }
}
