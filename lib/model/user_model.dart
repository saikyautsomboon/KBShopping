import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String usertype;
  final String address;
  final String phone;
  final String email;
  final String password;
  final String avatar;
  final String lat;
  final String lng;
  UserModel({
    this.id,
    this.name,
    this.usertype,
    this.address,
    this.phone,
    this.email,
    this.password,
    this.avatar,
    this.lat,
    this.lng,
  });

  UserModel copyWith({
    String id,
    String name,
    String usertype,
    String address,
    String phone,
    String email,
    String password,
    String avatar,
    String lat,
    String lng,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      usertype: usertype ?? this.usertype,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'usertype': usertype,
      'address': address,
      'phone': phone,
      'email': email,
      'password': password,
      'avatar': avatar,
      'lat': lat,
      'lng': lng,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      usertype: map['usertype'],
      address: map['address'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
      avatar: map['avatar'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, usertype: $usertype, address: $address, phone: $phone, email: $email, password: $password, avatar: $avatar, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.usertype == usertype &&
        other.address == address &&
        other.phone == phone &&
        other.email == email &&
        other.password == password &&
        other.avatar == avatar &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        usertype.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        password.hashCode ^
        avatar.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }
}
