part of '../../luoyi_flutter_base.dart';

extension FlutterStringExtension on String {
  bool get isInt => int.tryParse(this) != null;

  bool get isDouble => double.tryParse(this) != null;

  bool get isBool => bool.tryParse(this) != null;
}
