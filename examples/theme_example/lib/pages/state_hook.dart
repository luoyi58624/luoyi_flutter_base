import 'package:theme_example/global.dart';

class StatefulHookPage extends StatefulHookWidget {
  const StatefulHookPage({super.key});

  @override
  State<StatefulHookPage> createState() => _StatefulHookPageState();
}

class _StatefulHookPageState extends State<StatefulHookPage> {

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('有状态Hook页面'),
      ),
      body: buildCenterColumn([
        ElevatedButton(onPressed: ()=>count.value++, child: Text('count: ${count.value}'))
      ]),
    );
  }
}

