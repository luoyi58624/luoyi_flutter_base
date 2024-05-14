import 'package:base_example/global.dart';
import 'package:isar/isar.dart';

import 'models/user.dart';

late Isar isar;

Future<void> initIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [UserSchema],
    directory: dir.path,
  );
}
