import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:example/global.dart';

class HookDemoPage extends HookWidget {
  const HookDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var m1 = const TypographyModel();
    var m2 = const TypographyModel();
    i(m1 == m2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hook测试页面'),
      ),
      body: ColumnWidget(children: [
        useButton(_useStateData()),
        H1([
          'xxx',
        ]),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            P('xxxxx'),
            P('xxxxx', color: Colors.red),
            H1('xxxxxaxasx行啊阿萨x'),
            P('xx闲杂洒下行啊伤心啊伤心啊剩下阿萨xxx'),
          ],
        ),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "隐私条款 ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              TextSpan(
                  text: "https://www.baidu.com",
                  style: const TextStyle(fontSize: 18, color: Colors.redAccent),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("查看条款");
                    }),
            ],
          ),
        ),
      ]),
    );
  }
}

Widget useButton(HookRecoard hook) {
  useEffect(() {
    i(hook.count.value);
    // if (count.value > 30) {
    //   return count.dispose;
    // } else {
    //   return null;
    // }
    return null;
  }, [hook.count.value]);

  return Column(
    children: [
      Text('${hook.count.value * 2}'),
      ElevatedButton(
        onPressed: () => hook.addCount(),
        child: Text('count: ${hook.count.value}'),
      ),
    ],
  );
}

typedef HookRecoard = ({
  ValueNotifier<int> count,
  void Function() addCount,
});

HookRecoard _useStateData() {
  final count = useState(0);

  void addCount() {
    count.value++;
  }

  return (count: count, addCount: addCount);
}
