class Tabungan {
  String tanggal;
  String total;

  Tabungan({
    required this.tanggal,
    required this.total,
  });

  factory Tabungan.fromJson(Map<dynamic, dynamic> json) {
    return Tabungan(
      tanggal: json['tanggal'],
      total: json["total"] as String,
    );
  }
  Map<String, dynamic> toJson() =>
      {"tanggal": tanggal, "total": total};
 
}
