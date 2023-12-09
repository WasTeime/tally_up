import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final DateTime? created_at;
  final String email;
  final String? phone;
  final String photo;
  final String username;

  //TODO: можно попробовать тут заюзать именованные конструкторы
  UserModel(this.uid, this.created_at, this.phone,
      {this.email = "", this.photo = "", this.username = ""});

  Map<String, dynamic> toJson() {
    return {
      'created_at': created_at,
      'email': email,
      'phone': phone,
      'photo': photo,
      'username': username,
    };
  }

  //TODO: можно даже какой-нибудь Future<bool>, чтобы если ошибка вылетит сказать пользователю типо не получилось зарегать
  void createNewUserInDB() {
    final _db = FirebaseFirestore.instance;
    _db.collection('users').doc(uid).set(toJson());
  }
}
