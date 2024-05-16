part of '../../luoyi_flutter_base.dart';

/// loading加载框
class LoadingUtil {
  LoadingUtil._();

  /// 判断当前页面是否已经打开loading，如果有，则下次打开新的loading需要移除上一个loading
  static bool _isShowLoading = false;

  /// 创建loading的时间
  static int _createLoadingStartTime = 0;

  /// loading持续时间
  static int _loadingDuration = 0;

  /// 是否显示请求关闭loading提示框
  static bool _isShowConfirm = false;

  /// 显示 Loading 弹窗，如果之前打开了一个，将关闭之前的弹窗。
  ///
  /// 请注意：如果你在 initState 生命周期中使用它（例如在 initState 中执行网络请求），
  /// 请在 WidgetsBinding.instance.addPostFrameCallback 回调函数中调用，它会在UI构建完成后执行一次回调。
  ///
  /// 示例：
  /// ```dart
  ///  @override
  ///  void initState() {
  ///     super.initState();
  ///     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  ///       loading.show('请求数据中');
  ///       await Future.delayed(const Duration(seconds: 2));
  ///       loading.close();
  ///     });
  ///  }
  /// ```
  static Future<void> show(
    String title, {
    // 延迟关闭loading，它可以防止异步逻辑执行过快造成视觉闪烁，例如异步逻辑执行了50毫秒，
    // 那么loading会在50毫秒后关闭，页面会突然闪出一个弹窗然后瞬间关闭，此时用户体验非常不好；

    // 注意：如果你执行完异步逻辑后需要返回上一页，执行LoadingUtil.close时需要添加await，
    // 因为延迟关闭loading是不会阻塞后面代码的执行，关闭弹窗实际上只是执行弹出路由：router.back()，
    // 所以，如果你执行完异步逻辑后需要返回上一页，你必须等待loading关闭后再执行 router.back() 进行返回操作，
    // 否则你只是直接关闭了loading。
    int delayClose = 0,
    // 取消token，如果你需要当用户手动关闭loading时取消请求，那么请传递该token
    CancelToken? cancelToken,
  }) async {
    await close(true);
    _isShowLoading = true;
    _loadingDuration = delayClose;
    _createLoadingStartTime = DateTime.now().millisecondsSinceEpoch;
    if (_rootContext.mounted) {
      showDialog(
        context: _rootContext,
        barrierColor: Colors.black26,
        builder: (context) {
          return _LoadingWidget(
            title: title,
            cancelToken: cancelToken,
          );
        },
      );
    }
  }

  /// 如果页面上存在loading弹窗，则关闭。
  ///
  /// immedClose - 是否立即关闭弹窗
  static Future<void> close([bool? immedClose]) async {
    if (_isShowLoading) {
      if (_isShowConfirm) {
        _pop();
        await 0.05.delay();
      }
      _isShowConfirm = false;
      _isShowLoading = false;
      if (immedClose == true) {
        _pop();
      } else {
        var endTime = DateTime.now().millisecondsSinceEpoch;
        var delayCloseLoadingTime =
            math.max<int>((_loadingDuration - math.min(endTime - _createLoadingStartTime, 1000)), 0);
        if (delayCloseLoadingTime <= 0) {
          _pop();
        } else {
          Future.delayed(Duration(milliseconds: delayCloseLoadingTime), () {
            if (_rootContext.mounted) _pop();
          });
        }
      }
    }
  }

  static void _pop() {
    Navigator.of(_rootContext).pop();
  }
}

/// 构建loading组件
class _LoadingWidget extends StatefulWidget {
  const _LoadingWidget({required this.title, this.cancelToken});

  final String title;
  final CancelToken? cancelToken;

  @override
  State<_LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget> {
  Future<bool> showConfirm() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        LoadingUtil._isShowConfirm = true;
        LoadingUtil._isShowConfirm = await context.showConfirmModal(title: '你要关闭 loading 吗？');
        if (context.mounted && LoadingUtil._isShowConfirm) {
          LoadingUtil._isShowLoading = false;
          if (widget.cancelToken != null) {
            widget.cancelToken!.cancel();
          }
          Navigator.pop(context);
        }
      },
      child: Material(
        type: MaterialType.transparency,
        elevation: 2,
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
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
