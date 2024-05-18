part of '../../luoyi_flutter_base.dart';

extension FlutterModalExtension on BuildContext {
  Future<LabelModel?> showActionModal(List<LabelModel> models) async {
    var result = await showCupertinoModalPopup<LabelModel>(
      context: this,
      builder: (BuildContext context) => CupertinoActionSheet(
          actions: models
              .map((e) => CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context, e);
                    },
                    child: Text(e.label),
                  ))
              .toList()),
    );
    return result;
  }

  /// 显示取消、确认提示框
  Future<bool> showConfirmModal({
    String title = '提示',
    String? content,
    bool canPop = true, // 是否可以通过返回键返回，若为false，barrierDismissible属性将无效
    bool barrierDismissible = true, // 是否允许用户点击遮罩关闭弹窗
    Widget? contentWidget, // 自定义内容widget
    Widget? cancelWidget, // 取消widget
    Widget? confirmWidget, // 确认widget
    bool titleCenter = false, // 标题是否居中
    bool showCancel = true,
    bool showConfirm = true,
    String cancelText = '取 消',
    String confirmText = '确 认',
    Color? cancelColor,
    Color? confirmColor,
    Function? onCancel,
    Function? onConfirm,
  }) async {
    bool? result = await showDialog<bool>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => PopScope(
        canPop: canPop,
        child: AlertDialog(
          title: Text(
            title,
            textAlign: titleCenter ? TextAlign.center : TextAlign.start,
          ),
          content: contentWidget ?? (content != null ? Text(content) : null),
          actions: <Widget>[
            if (showCancel)
              cancelWidget ??
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      if (onCancel != null) onCancel();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: cancelColor ?? Colors.grey,
                    ),
                    child: Text(cancelText),
                  ),
            if (showConfirm)
              confirmWidget ??
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      if (onConfirm != null) onConfirm();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: confirmColor ?? context.appTheme.primary,
                    ),
                    child: Text(confirmText),
                  ),
          ],
        ),
      ),
    );

    return result == true;
  }

  /// 显示输入框提示框
  Future<void> showInputModal({
    String title = '提示',
    String cancelText = '取消',
    String confirmText = '确认',
    Function(String value)? onConfirm,
  }) async {
    await showDialog(
      context: this,
      builder: (context) => InputDialogWidget(
        title: title,
        cancelText: cancelText,
        confirmText: confirmText,
        onConfirm: onConfirm,
      ),
    );
  }
}

class InputDialogWidget extends StatefulWidget {
  const InputDialogWidget({
    super.key,
    this.title = '提示',
    this.cancelText = '取消',
    this.confirmText = '确认',
    this.onConfirm,
  });

  final String title;
  final String cancelText;
  final String confirmText;
  final Function(String value)? onConfirm;

  @override
  State<InputDialogWidget> createState() => _InputDialogWidgetState();
}

class _InputDialogWidgetState extends State<InputDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: _buildForm(),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(widget.cancelText),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate() == true) {
              Navigator.of(context).pop();
              if (widget.onConfirm != null) {
                widget.onConfirm!(_controller.text);
              }
            }
          },
          child: Text(widget.confirmText),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _controller,
        autofocus: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '必填';
          }
          return null;
        },
      ),
    );
  }
}
