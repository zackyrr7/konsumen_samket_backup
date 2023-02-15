// ignore_for_file: non_constant_identifier_names



class Cuci {
  int id;
  String nama;
  String nomor_hp;
  String jenis;

  Cuci({required this.id, required this.nama, required this.nomor_hp, required this.jenis});

  factory Cuci.fromJson(Map<String, dynamic> json) {
    return Cuci(
      id: json['id'],
      nama: json['nama'],
      nomor_hp: json['nomor_hp'],
      jenis: json['jenis'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "name": nama, "nomor_hp": nomor_hp, "jenis": jenis};
}
