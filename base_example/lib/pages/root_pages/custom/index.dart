import 'package:flutter/material.dart';

import '../../../global.dart';

class CustomRootPage extends StatefulWidget {
  const CustomRootPage({super.key});

  @override
  State<CustomRootPage> createState() => _CustomRootPageState();
}

class _CustomRootPageState extends State<CustomRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).appbarLabelCustom)),
      body: Container(),
    );
  }

  Widget test() {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            collapsedHeight: context.appbarHeight,
            toolbarHeight: context.appbarHeight,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(vertical: context.appbarHeight / 4),
              title: Text(
                S.of(context).appbarLabelCustom,
              ),
              centerTitle: true,
            ),
            centerTitle: false,
            titleSpacing: 0,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
          SuperSliverList.builder(
            itemCount: 1000,
            itemBuilder: (context, index) => ListTile(
              title: Text('列表 - ${index + 1}'),
            ),
          ),
        ],
      ),
    );
  }
}
