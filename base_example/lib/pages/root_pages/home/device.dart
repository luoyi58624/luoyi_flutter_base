import 'package:flutter/cupertino.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:mini_getx/mini_getx.dart';

class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Device测试'),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: buildCenterColumn([
            const SizedBox(height: 8),
            CupertinoButton.filled(
              child: const Text('获取当前设备信息'),
              onPressed: () {
                context.push(const _DeviceData());
              },
            ),
            const SizedBox(height: 8),
            CupertinoButton.filled(
              child: const Text('判断Android设备型号'),
              onPressed: () {
                context.push(const _DeviceManufacturer());
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class _DeviceData extends StatelessWidget {
  const _DeviceData();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (GetPlatform.isWeb) {
      widgets = buildWidgets(DeviceUtil.webInfo!.data);
    } else {
      if (GetPlatform.isAndroid) {
        widgets = buildWidgets(DeviceUtil.androidInfo!.data);
      } else if (GetPlatform.isMacOS) {
        widgets = buildWidgets(DeviceUtil.macInfo!.data);
      }
    }
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('设备信息'),
        previousPageTitle: 'Device测试',
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: buildCenterColumn(widgets),
        ),
      ),
    );
  }

  List<Widget> buildWidgets(Map<String, dynamic> data) {
    return data.keys
        .map(
          (e) => CupertinoListTile(
            onTap: () {
              i(data[e], e);
            },
            title: Text(e),
            trailing: DartUtil.isBaseType(data[e])
                ? Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            data[e].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        )
        .toList();
  }
}

class _DeviceManufacturer extends StatelessWidget {
  const _DeviceManufacturer();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('当前Android设备')),
      child: SafeArea(
        child: SingleChildScrollView(
          child: buildCenterColumn([
            if (GetPlatform.isAndroid)
              ...DeviceUtil.allAndroidManufacturer.keys.map(
                (k) => CupertinoListTile(
                  title: Text(DeviceUtil.allAndroidManufacturer[k]!),
                  trailing: Text((DeviceUtil.androidInfo!.manufacturer.toLowerCase() == k).toString()),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
