import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class BaseHttpPage extends HookWidget {
  const BaseHttpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = useState('');
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础Http测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildCenterColumn([
          Text('请求的数据：${text.value}'),
          ElevatedButton(
            onPressed: () async {
              GetPlatform.isIOS;
              // var resData = http.test();
              LoadingUtil.show('加载中');
              var resData = await http.get('https://jsonplaceholder.typicode.com/todos/1');
              LoadingUtil.close();
              text.value = resData.toString();
            },
            child: const Text('发送get请求'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              LoadingUtil.show('加载中');
              var resData = await myHttp.test('/todos/1');
              LoadingUtil.close();
              text.value = resData.toString();
            },
            child: const Text('发送get请求 - 自定义http'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              LoadingUtil.show('加载中');
              var resData = await myHttp.get(
                '/todos/1',
                getRequestExtra: GetRequestExtra(
                  enableCache: true,
                  useCache: true,
                ),
              );
              text.value = resData.toString();
            },
            child: const Text('发送get请求 - 自定义http - 缓存请求数据'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              text.value = '';
              i(http.instance == myHttp.instance);
              i(http.instance.options.baseUrl);
              i(myHttp.instance.options.baseUrl);
            },
            child: const Text('清空数据'),
          ),
        ]),
      ),
    );
  }
}
