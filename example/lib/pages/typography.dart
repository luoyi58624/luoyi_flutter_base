import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../global.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文字排版'),
      ),
      body: SingleChildScrollView(
        child: ColumnWidget(children: [
          // H1('一级Title'),
          // H2('二级Title'),
          // H3('三级Title'),
          // H4('四级Title'),
          // H5('五级Title'),
          // H6('六级Title'),
          // P('普通文本'),
          // A(
          //   'https://www.baidu.com',
          //   style: TextStyle(
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // P(['这是一段文字，里面包含', B('加粗'), '、', I('斜体'), '、', '文字']),
          // P([
          //   '富文行啊伤心啊剩下阿是本',
          //   P('红色行啊伤心啊剩下行啊剩下阿是x文本', style: TextStyle(color: Colors.red)),
          //   Icon(Icons.home),
          //   H1('一级Title'),
          //   H1('一级Title', style: TextStyle(color: Colors.purple)),
          //   H2([
          //     Text('二级标题'),
          //     Text(
          //       '二级标题',
          //       style: TextStyle(color: Colors.green),
          //     ),
          //   ]),
          // ]),
          const Span([
            'xx想你想金阿奎少女心看书你先看久啊少女心卡视角',
            Span('红色行啊伤心啊剩下行啊剩下阿是x文本', style: TextStyle(color: Colors.red)),
            Icon(Icons.home),
            Icon(Icons.home),
            Span(
              '加粗文本',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            A('超链接'),
            'xx想你想金阿奎少女心看书你先看久啊少女心卡视角',
            'xx想你想金阿奎少女心看书你先看久啊少女心卡视角',
          ]),
          const Gap(16),
          DefaultTextStyle(
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
            child: Builder(builder: (context) {
              return RichText(
                text: TextSpan(
                  text: 'xx想你想金阿奎少女心看书你先看久啊少女心卡视角',
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'hello西南科技安心卡就是你看那就行那可就少女心久啊收纳显卡收纳',
                      style: TextStyle(color: Colors.red),
                      children: [
                        TextSpan(text: '罗伊'),
                      ],
                    ),
                    WidgetSpan(child: Icon(Icons.home)),
                    WidgetSpan(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.green,
                      ),
                    ),
                    WidgetSpan(child: Text('陆毅')),
                    TextSpan(text: '陆毅'),
                    TextSpan(
                      text: 'hello西南科技安心卡就是你看那就行那可就少女心久啊收纳显卡收纳',
                      style: TextStyle(color: Colors.green),
                      children: [
                        TextSpan(text: '罗伊'),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ]),
      ),
    );
  }
}
