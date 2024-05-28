import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';
import 'package:simple_widget/simple_widget.dart';

void main() {
  runApp(const _App());
}

class _App extends HookWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xffffffff),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(100, (index) => const _Child()),
            ),
          ),
        ),
      ),
    );
  }
}

class _Child extends HookWidget {
  const _Child();

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.maxFinite,
        child: Center(
          child: Button(
            onPressed: () {
              count.value++;
            },
            child: Text('count: ${count.value}'),
          ),
        ),
      ),
    );
  }
}
