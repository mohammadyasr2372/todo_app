// ignore_for_file: use_super_parameters


import '../../domin/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    int? id,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? token,
    String? image,
    String? address,
    String? password,
  }) : super(
          id: id,
          username: username,
          firstName: firstName,
          lastName: lastName,
          email: email,
          token: token,
          image: image,
          address: address,
          password: password,
        );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      token: entity.token,
      image: entity.image,
      address: entity.address,
      password: entity.password,
    );
  }
}
