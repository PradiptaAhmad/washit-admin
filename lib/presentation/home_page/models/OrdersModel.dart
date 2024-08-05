class OrdersModel {
  int? id;
  String? noPemesanan;
  String? namaLaundry;
  String? jenisPemesanan;
  String? alamat;
  String? tanggalEstimasi;
  String? tanggalPemesanan;
  String? namaPemesan;
  int? beratLaundry;
  int? totalHarga;
  String? status;

  OrdersModel(
      {this.id,
      this.noPemesanan,
      this.namaLaundry,
      this.jenisPemesanan,
      this.alamat,
      this.tanggalEstimasi,
      this.tanggalPemesanan,
      this.namaPemesan,
      this.beratLaundry,
      this.totalHarga,
      this.status});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noPemesanan = json['no_pemesanan'];
    namaLaundry = json['nama_laundry'];
    jenisPemesanan = json['jenis_pemesanan'];
    alamat = json['alamat'];
    tanggalEstimasi = json['tanggal_estimasi'];
    tanggalPemesanan = json['tanggal_pemesanan'];
    namaPemesan = json['nama_pemesan'];
    beratLaundry = json['berat_laundry'];
    totalHarga = json['total_harga'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_pemesanan'] = this.noPemesanan;
    data['nama_laundry'] = this.namaLaundry;
    data['jenis_pemesanan'] = this.jenisPemesanan;
    data['alamat'] = this.alamat;
    data['tanggal_estimasi'] = this.tanggalEstimasi;
    data['tanggal_pemesanan'] = this.tanggalPemesanan;
    data['nama_pemesan'] = this.namaPemesan;
    data['berat_laundry'] = this.beratLaundry;
    data['total_harga'] = this.totalHarga;
    data['status'] = this.status;
    return data;
  }
}
