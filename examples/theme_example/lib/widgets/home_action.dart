import 'package:theme_example/global.dart';

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      enableFeedback: true,
      offset: Offset(0, context.appConfig.appbarHeight + 4),
      popUpAnimationStyle: AnimationStyle.noAnimation,
      icon: const Icon(Icons.color_lens),
      onSelected: (value) {
        AppController.of.selectPresetTheme.value = value;
      },
      itemBuilder: (context) {
        return ['默认配置', 'M2默认主题', 'M2扁平化配置', 'M3默认主题', 'M3扁平化配置']
            .mapIndexed((index, value) => PopupMenuItem(
                  height: 40,
                  value: index,
                  child: Row(
                    children: [
                      if (index == AppController.of.selectPresetTheme.value)
                        Icon(
                          Icons.check,
                          color: context.appTheme.iconColor,
                        ).padding(right: 8),
                      Text(value),
                    ],
                  ),
                ))
            .toList();
      },
    );
  }
}
