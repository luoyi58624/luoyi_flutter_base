part of '../../luoyi_flutter_base.dart';

/// 注入控制器hook，当页面移除后将自动销毁控制器，注意：仅限mini_getx
/// * tag 控制器标签
/// * showLog 注入控制器、销毁控制器时是否打印日志
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
