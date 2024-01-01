import 'package:cloud_firestore/cloud_firestore.dart';

enum Role { participant, creator }

class GroupModel {
  final String groupName;
  final List<DocumentReference> participants;
  final Role role;
  final DateTime? created_at;

  GroupModel(
      {required this.groupName,
      required this.participants,
      required this.role,
      this.created_at});

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'participants': participants,
      'role': role.name,
      'created_at': created_at
    };
  }
}
