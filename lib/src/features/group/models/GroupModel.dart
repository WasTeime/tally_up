class GroupModel {
  final String groupName;
  final DateTime? created_at;

  GroupModel({
    required this.groupName,
    this.created_at,
  });

  Map<String, dynamic> toJson() {
    return {'groupName': groupName, 'created_at': created_at};
  }
}
