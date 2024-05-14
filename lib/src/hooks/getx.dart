part of '../../luoyi_flutter_base.dart';

/// 注入Getx控制器hook
T useGetx<T extends GetxController>(
  T controller, {
  String? tag,
  bool showLog = true,
}) {
  return use(_Controller(controller, tag, showLog));
}

class _Controller<T extends GetxController> extends Hook<T> {
  const _Controller(this.controller, this.tag, this.showLog);

  final T controller;
  final String? tag;
  final bool showLog;

  @override
  _ControllerState<T> createState() => _ControllerState();
}

class _ControllerState<T extends GetxController> extends HookState<T, _Controller<T>> {
  late final T c = Get.put(hook.controller, tag: hook.tag, showLog: hook.showLog);

  @override
  T build(BuildContext context) => c;

  @override
  void dispose() {
    Get.delete<T>(tag: hook.tag);
  }
}
