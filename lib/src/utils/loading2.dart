part of '../../luoyi_flutter_base.dart';

class LoadingUtil2 {
  // static late BuildContext _overlayContext;

  // static void _init(BuildContext context) {
  //   _overlayContext = _rootContext;
  // }

  static OverlayEntry? _overlayEntry;

  static void show(String text) {
    if (_overlayEntry != null) close();
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return _LoadingWidget2(text);
      },
    );
    Overlay.of(_rootContext).insert(_overlayEntry!);
  }

  /// 关闭当前屏幕上的抽屉
  static void close() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}

class _LoadingWidget2 extends HookWidget {
  const _LoadingWidget2(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onWillPop: () async {
      //   return false;
      // },
      child: Positioned(
        top: 0.0,
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Material(
          color: Colors.black26,
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade700.withOpacity(0.85)
                    : Colors.grey.shade900.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircularProgressIndicator(color: Colors.white),
                  const SizedBox(height: 24),
                  Container(
                    constraints: const BoxConstraints(minWidth: 120, maxWidth: 150),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontUtil.medium),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
