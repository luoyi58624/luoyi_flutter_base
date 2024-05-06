import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../widgets/button.dart';

class ButtonTestPage extends StatelessWidget {
  const ButtonTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button测试页面'),
      ),
      body: buildCenterColumn([
        ButtonWidget(
          onPressed: () {
            context.push(const _MyButtonTestPage());
          },
          child: const Text('自定义button测试页面'),
        ),
        const SizedBox(height: 8),
        ButtonWidget(
          onPressed: () {
            context.push(const _MaterialButtonTestPage());
          },
          child: const Text('material button测试页面'),
        ),
      ]),
    );
  }
}

class _MyButtonTestPage extends StatefulWidget {
  const _MyButtonTestPage({super.key});

  @override
  State<_MyButtonTestPage> createState() => _MyButtonTestPageState();
}

class _MyButtonTestPageState extends State<_MyButtonTestPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义 Button'),
      ),
      body: SingleChildScrollView(
        child: buildCenterColumn(
          List.generate(
            10000,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ButtonWidget(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: Text('count: $count'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MaterialButtonTestPage extends StatefulWidget {
  const _MaterialButtonTestPage({super.key});

  @override
  State<_MaterialButtonTestPage> createState() => _MaterialButtonTestPageState();
}

class _MaterialButtonTestPageState extends State<_MaterialButtonTestPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Button'),
      ),
      body: SingleChildScrollView(
        child: buildCenterColumn(
          List.generate(
            10000,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: Text('count: $count'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
