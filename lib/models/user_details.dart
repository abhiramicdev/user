import 'dart:convert';

class UserDetails {
  int? id;
  String? name;
  String? username;
  String? email;
  String? profileImage;
  String? phone;
  String? website;
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  String? companyName;
  String? catchPhrase;
  String? bs;

  UserDetails({
    this.id,
    this.name,
    this.username,
    this.email,
    this.profileImage,
    this.phone,
    this.website,
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.companyName,
    this.catchPhrase,
    this.bs,
  });

  factory UserDetails.fromMap(Map<String, dynamic> json) => new UserDetails(
        id: json["id"],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        profileImage: json['profileImage'],
        phone: json['phone'],
        website: json['website'],
        street: json['street'],
        suite: json['suite'],
        city: json['city'],
        zipcode: json['zipcode'],
        companyName: json['companyName'],
        catchPhrase: json['catchPhrase'],
        bs: json['bs'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "profileImage": profileImage,
        "phone": phone,
        "website": website,
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "companyName": companyName,
        "catchPhrase": catchPhrase,
        "bs": bs,

      };
}

UserDetails clientFromJson(String str) {
  final jsonData = json.decode(str);
  return UserDetails.fromMap(jsonData);
}

String clientToJson(UserDetails data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
