part of '../../luoyi_flutter_base.dart';

const Widget arrowRightWidget = Icon(Icons.keyboard_arrow_right);

/// 构建滚动组件
Widget buildScrollWidget({
  required Widget child,
  ScrollController? controller,
  bool showScrollbar = true,
}) {
  Widget widget = SingleChildScrollView(
    controller: controller,
    child: child,
  );
  if (showScrollbar) {
    return widget = buildScrollbar(
      controller: controller,
      child: widget,
    );
  }
  return widget;
}

/// 构建通用的[ListTile]组件
Widget buildListTileWidget(
  BuildContext context, {
  required String title,
  bool dense = true,
  Widget trailing = arrowRightWidget,
  GestureTapCallback? onTap,
  Widget? page,
  Widget? leading,
  Color? tileColor,
}) {
  return ListTile(
    onTap: onTap == null && page == null
        ? null
        : () {
            if (onTap != null) {
              onTap();
            } else {
              context.push(page!);
            }
          },
    dense: dense,
    leading: leading,
    trailing: arrowRightWidget,
    tileColor: tileColor,
    title: Text(
      title,
      style: TextStyle(
        fontSize: Theme.of(context).listTileTheme.titleTextStyle?.fontSize,
      ),
    ),
  );
}

/// 构建通用分割线Widget
Widget buildDividerWidget(
  BuildContext context, {
  double height = 0,
  double thickness = 0.5,
  double indent = 0,
  Color? color,
}) {
  return Divider(
    height: height,
    thickness: thickness,
    indent: indent,
    color: color ?? (context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
  );
}

/// 构建通用的列表分割线widget
IndexedWidgetBuilder buildSeparatorWidget(
  BuildContext context, {
  double height = 0,
  double thickness = 0.5,
  double indent = 0,
  Color? color,
}) {
  return (ctx, index) => buildDividerWidget(
        context,
        height: height,
        thickness: thickness,
        indent: indent,
        color: color,
      );
}

Widget buildListViewDemo({
  int? count,
  ScrollPhysics? physics,
}) {
  return ListView.builder(
    itemCount: count,
    physics: physics,
    itemBuilder: (context, index) => buildListTileWidget(
      context,
      onTap: () {},
      title: '列表-${index + 1}',
    ),
  );
}

Widget buildCardCell(
  BuildContext context, {
  required String title,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('基础组件', style: context.h4),
          ),
          Column(
            children: [
              ListTile(
                onTap: () {},
                dense: true,
                title: const Text('Button 按钮', style: TextStyle(fontSize: 15)),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
              ListTile(
                onTap: () {},
                dense: true,
                title: const Text('Switch 开关', style: TextStyle(fontSize: 15)),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildPopupMenuButton({
  Offset? offset,
}) {
  return PopupMenuButton(
    elevation: 2,
    offset: const Offset(0, 50),
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
      const PopupMenuItem(
        child: Text('MaterialApp'),
      ),
      const PopupMenuItem(
        child: Text('CupertinoApp'),
      ),
      const PopupMenuItem(
        child: Text('重启App'),
      ),
    ],
  );
}

Widget buildCenterColumn(List<Widget> children) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget buildBoxWidget({
  double width = 36,
  double height = 36,
  double radius = 4,
  Color color = Colors.grey,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
    ),
  );
}

/// 构建滚动条，如果是桌面端(包括桌面端web)，直接返回字元素
Widget buildScrollbar({
  required Widget child,
  ScrollController? controller,
  bool thumbVisibility = false, // 是否一直显示滚动条
}) {
  if (GetPlatform.isDesktop) return child;
  return Scrollbar(
    controller: controller,
    thumbVisibility: thumbVisibility,
    child: child,
  );
}

/// 构建ios滚动条，如果是桌面端(包括桌面端web)，则不使用ios滚动条，因为会冲突
Widget buildCupertinoScrollbar({
  required Widget child,
  ScrollController? controller,
  bool thumbVisibility = false, // 是否一直显示滚动条
}) {
  if (GetPlatform.isDesktop) return child;
  return CupertinoScrollbar(
    controller: controller,
    thumbVisibility: thumbVisibility,
    child: child,
  );
}

/// 构建ios loading
Widget buildCupertinoLoading({
  double radius = 16,
  bool animating = true,
  Color? color,
}) =>
    CupertinoActivityIndicator(
      animating: animating,
      radius: radius,
      color: color,
    );

/// ios加载loading预设
class CupertinoLoadingPreset {
  CupertinoLoadingPreset._();

  static const Widget mini = CupertinoActivityIndicator(
    animating: true,
    radius: 8,
  );

  static const Widget small = CupertinoActivityIndicator(
    animating: true,
    radius: 12,
  );

  static const Widget medium = CupertinoActivityIndicator(
    animating: true,
    radius: 16,
  );

  static const Widget large = CupertinoActivityIndicator(
    animating: true,
    radius: 20,
  );
}
