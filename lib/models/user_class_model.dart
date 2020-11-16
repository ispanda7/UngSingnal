import 'dart:convert';

class UserClassModel {
  final String id;
  final String name;
  final String user;
  final String password;
  UserClassModel({
    this.id,
    this.name,
    this.user,
    this.password,
  });

  UserClassModel copyWith({
    String id,
    String name,
    String user,
    String password,
  }) {
    return UserClassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Name': name,
      'User': user,
      'Password': password,
    };
  }

  factory UserClassModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserClassModel(
      id: map['id'],
      name: map['Name'],
      user: map['User'],
      password: map['Password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserClassModel.fromJson(String source) => UserClassModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserClassModel(id: $id, Name: $name, User: $user, Password: $password)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserClassModel &&
      o.id == id &&
      o.name == name &&
      o.user == user &&
      o.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      user.hashCode ^
      password.hashCode;
  }
}
