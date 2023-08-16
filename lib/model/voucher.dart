class Voucher {
  int? statusCode;
  Datas? datas;

  Voucher({this.statusCode, this.datas});

  Voucher.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    datas = json['datas'] != null ? new Datas.fromJson(json['datas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    if (this.datas != null) {
      data['datas'] = this.datas!.toJson();
    }
    return data;
  }
}

class Datas {
  int? id;
  String? kode;
  int? nominal;
  String? createdAt;
  String? updatedAt;

  Datas({this.id, this.kode, this.nominal, this.createdAt, this.updatedAt});

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nominal = json['nominal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode'] = this.kode;
    data['nominal'] = this.nominal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
