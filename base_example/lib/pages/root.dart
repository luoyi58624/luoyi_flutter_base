import 'package:flutter/material.dart';

import '../global.dart';
import 'root_pages/cupertino/index.dart';
import 'root_pages/custom/index.dart';
import 'root_pages/home/index.dart';
import 'root_pages/material/index.dart';
import 'root_pages/my/index.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeRootPage(),
          MaterialRootPage(),
          CupertinoRootPage(),
          CustomRootPage(),
          MyRootPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).bottomLabelHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.android),
            label: S.of(context).bottomLabelMaterial,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.apple),
            label: S.of(context).bottomLabelCupertino,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.token_outlined),
            label: S.of(context).bottomLabelCustom,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: S.of(context).bottomLabelUser,
          ),
        ],
      ),
    );
  }
}
