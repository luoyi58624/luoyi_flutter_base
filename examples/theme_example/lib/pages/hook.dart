import 'package:theme_example/global.dart';

class HookDemoPage extends HookWidget {
  const HookDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hook测试页面'),
      ),
      body: buildCenterColumn([
        useButton(_useStateData()),
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

