import 'package:tally_up/src/core/data/DBModel.dart';

class CreateGroupDBModel extends DBModel {
  CreateGroupDBModel(String userUid)
      : super(pathToCollection: {'users': userUid, 'groups': null});
}
