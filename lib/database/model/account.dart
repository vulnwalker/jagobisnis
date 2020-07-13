class Account {
  int id;
  String _email;
  String _password;
  String _nama;
  String _nomor_telepon;
  String _lisensi;
  String _nama_rekening;
  String _nama_bank;
  String _nomor_rekening;
  int _saldo,_profit,_jumlah_barang;
  int _status;
  String _kota;
  Account(this._email, this._password, this._nama, this._nomor_telepon,this._jumlah_barang,this._nama_bank,this._nomor_rekening, this._nama_rekening, this._lisensi, this._profit,this._status, this._kota);
  Account.map(dynamic obj) {
    this._email = obj["email"];
    this._password = obj["password"];
    this._nama = obj["nama"];
    this._nomor_telepon = obj["nomor_telepon"];
    this._jumlah_barang = obj["jumlah_barang"];
    this._nama_bank = obj["nama_bank"];
    this._nomor_rekening = obj["nomor_rekening"];
    this._nama_rekening = obj["nama_rekening"];
    this._lisensi = obj["lisensi"];
    this._profit = obj["profit"];
    this._status = obj["status"];
    this._kota = obj["kota"];
  }
  String get accountEmail => _email;
  String get accountPassword => _password;
  String get accountNama => _nama;
  String get accountNomorTelepon => _nomor_telepon;
  int get accountSaldo => _saldo;
  int get accountStatus => _status;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["email"] = this._email;
    map["password"] = this._password;
    map["nama"] = this._nama;
    map["nomor_telepon"] = this._nomor_telepon;
    map["jumlah_barang"] = this._jumlah_barang;
    map["nama_bank"] = this._nama_bank;
    map["nomor_rekening"] = this._nomor_rekening;
    map["nama_rekening"] = this._nama_rekening;
    map["lisensi"] = this._lisensi;
    map["profit"] = this._profit;
    map["status"] = this._status;
    map["kota"] = this._kota;
    return map;
  }
  void setAccountId(int id) {
    this.id = id;
  }
}
