import 'package:theme_example/global.dart';
import 'package:theme_example/widgets/common.dart';

class ButtonWidgets extends HookWidget {
  const ButtonWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    final selects = useState({0});
    return ComponentDecoration(title: 'Buttons', children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          ElevatedButton.icon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          ElevatedButton(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          FilledButton.icon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          FilledButton(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton.tonal(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          FilledButton.tonalIcon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          FilledButton.tonal(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          OutlinedButton.icon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          OutlinedButton(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          TextButton.icon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          TextButton(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
          ),
          IconButton.filled(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
          ),
          IconButton.filledTonal(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
          ),
          IconButton.outlined(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
          IconButton.filled(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
          IconButton.filledTonal(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
          IconButton.outlined(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () => count.value++,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.extended(
            onPressed: () => count.value++,
            heroTag: null,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          FloatingActionButton.small(
            onPressed: () => count.value++,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.large(
            onPressed: () => count.value++,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      const Gap(16),
      SegmentedButton<int>(
        segments: const <ButtonSegment<int>>[
          ButtonSegment(value: 0, label: Text('选项一'), icon: Icon(Icons.calendar_view_day)),
          ButtonSegment(value: 1, label: Text('选项二'), icon: Icon(Icons.calendar_view_week)),
          ButtonSegment(value: 2, label: Text('选项三'), icon: Icon(Icons.calendar_view_month)),
        ],
        selected: selects.value,
        onSelectionChanged: (v) {
          selects.value = v;
        },
      ),
      const Gap(16),
      SegmentedButton<int>(
        segments: const <ButtonSegment<int>>[
          ButtonSegment(value: 0, label: Text('选项一')),
          ButtonSegment(value: 1, label: Text('选项二')),
          ButtonSegment(value: 2, label: Text('选项三')),
        ],
        selected: selects.value,
        onSelectionChanged: (v) {
          selects.value = v;
        },
      ),
    ]);
  }
}

Widget useButton() {
  final count = useState(0);
  return ElevatedButton(
    onPressed: () => count.value++,
    child: Text('count: ${count.value}'),
  );
}

class ButtonDemo extends HookWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return useButton();
  }
}
