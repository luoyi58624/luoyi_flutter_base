import 'package:flutter/material.dart';

import '../../../global.dart';

class MyRootPage extends StatefulWidget {
  const MyRootPage({super.key});

  @override
  State<MyRootPage> createState() => _MyRootPageState();
}

class _MyRootPageState extends State<MyRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue.shade700,
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 200.0,
            collapsedHeight: context.appbarHeight,
            toolbarHeight: context.appbarHeight,
            flexibleSpace: FlexibleSpaceBar(
              title: FlexibleTitleWidget(child: Text(S.of(context).appbarLabelUser)),
              background: const ImageWidget(asset: "assets/images/bg.png", fit: BoxFit.fill),
              collapseMode: CollapseMode.pin,
              titlePadding: EdgeInsets.symmetric(vertical: context.appbarHeight / 4),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
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
