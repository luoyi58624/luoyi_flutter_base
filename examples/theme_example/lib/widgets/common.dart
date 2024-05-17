import 'package:theme_example/global.dart';

class ComponentDecoration extends StatelessWidget {
  const ComponentDecoration({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.h4).padding(left: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
