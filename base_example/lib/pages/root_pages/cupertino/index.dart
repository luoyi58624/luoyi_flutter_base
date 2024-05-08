import 'package:flutter/cupertino.dart';

import '../../../global.dart';

class CupertinoRootPage extends StatefulWidget {
  const CupertinoRootPage({super.key});

  @override
  State<CupertinoRootPage> createState() => _CupertinoRootPageState();
}

class _CupertinoRootPageState extends State<CupertinoRootPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(S.of(context).appbarLabelCupertino),
      ),
      child: Container(),
    );
  }
}
