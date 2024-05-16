import 'package:theme_example/global.dart';

class ButtonWidgets extends HookWidget {
  const ButtonWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    final selects = useState({0});
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => count.value++,
          child: Text('count: ${count.value}'),
        ),
        TextButton(
          onPressed: () => count.value++,
          child: Text('count: ${count.value}'),
        ),
        IconButton(
          onPressed: () => count.value++,
          icon: const Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () => count.value++,
          heroTag: null,
          child: const Icon(Icons.add),
        ),
        const Gap(16),
        FloatingActionButton.extended(
          onPressed: () => count.value++,
          heroTag: null,
          icon: const Icon(Icons.add),
          label: Text('count: ${count.value}'),
        ),
        const Gap(16),
        SegmentedButton<int>(
          segments: const <ButtonSegment<int>>[
            ButtonSegment(value: 0, label: Text('Day'), icon: Icon(Icons.calendar_view_day)),
            ButtonSegment(value: 1, label: Text('Week'), icon: Icon(Icons.calendar_view_week)),
            ButtonSegment(value: 2, label: Text('Month'), icon: Icon(Icons.calendar_view_month)),
            ButtonSegment(value: 3, label: Text('Year'), icon: Icon(Icons.calendar_today)),
          ],
          selected: selects.value,
          onSelectionChanged: (v) {
            selects.value = v;
          },
        ),
      ],
    );
  }
}
