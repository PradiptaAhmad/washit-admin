class DetailHistoryModel {
  int id;
  String noPemesanan;
  String jenisPemesanan;
  String namaPemesan;
  String nomorTelepon;
  String alamat;
  String metodePembayaran;
  int beratLaundry;
  String catatan;
  dynamic catatanAlamat;
  String status;
  int totalHarga;
  DateTime tanggalPemesanan;
  DateTime tanggalPengambilan;
  String laundryService;
  String laundryDescription;
  String laundryPrice;

  DetailHistoryModel({
    required this.id,
    required this.noPemesanan,
    required this.jenisPemesanan,
    required this.namaPemesan,
    required this.nomorTelepon,
    required this.alamat,
    required this.metodePembayaran,
    required this.beratLaundry,
    required this.catatan,
    required this.catatanAlamat,
    required this.status,
    required this.totalHarga,
    required this.tanggalPemesanan,
    required this.tanggalPengambilan,
    required this.laundryService,
    required this.laundryDescription,
    required this.laundryPrice,
  });

  factory DetailHistoryModel.fromJson(Map<String, dynamic> json) => DetailHistoryModel(
    id: json["id"],
    noPemesanan: json["no_pemesanan"],
    jenisPemesanan: json["jenis_pemesanan"],
    namaPemesan: json["nama_pemesan"],
    nomorTelepon: json["nomor_telepon"],
    alamat: json["alamat"],
    metodePembayaran: json["metode_pembayaran"],
    beratLaundry: json["berat_laundry"],
    catatan: json["catatan"],
    catatanAlamat: json["catatan_alamat"],
    status: json["status"],
    totalHarga: json["total_harga"],
    tanggalPemesanan: DateTime.parse(json["tanggal_pemesanan"]),
    tanggalPengambilan: DateTime.parse(json["tanggal_pengambilan"]),
    laundryService: json["laundry_service"],
    laundryDescription: json["laundry_description"],
    laundryPrice: json["laundry_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_pemesanan": noPemesanan,
    "jenis_pemesanan": jenisPemesanan,
    "nama_pemesan": namaPemesan,
    "nomor_telepon": nomorTelepon,
    "alamat": alamat,
    "metode_pembayaran": metodePembayaran,
    "berat_laundry": beratLaundry,
    "catatan": catatan,
    "catatan_alamat": catatanAlamat,
    "status": status,
    "total_harga": totalHarga,
    "tanggal_pemesanan": tanggalPemesanan.toIso8601String(),
    "tanggal_pengambilan": tanggalPengambilan.toIso8601String(),
    "laundry_service": laundryService,
    "laundry_description": laundryDescription,
    "laundry_price": laundryPrice,
  };
}

