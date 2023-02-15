// ignore_for_file: non_constant_identifier_names

class User {
  int id;
  String name;
  String nomor_hp;

  User({required this.id, required this.name, required this.nomor_hp});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      nomor_hp: json['email'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "nomor_hp": nomor_hp};
}
