import 'package:base_example/db/isar.dart';
import 'package:base_example/db/models/user.dart';
import 'package:base_example/global.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class DbPage extends HookWidget {
  const DbPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = useState<List<User>>([]);
    final loading = useState(false);

    useEffect(() {
      users.value = isar.users.where().findAllSync();
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: const Text('数据库测试'),
      ),
      body: buildCenterColumn([
        ElevatedButton(
          onPressed: loading.value
              ? null
              : () async {
                  loading.value = true;
                  List<User> userList = [];
                  for (int i = 0; i < 100; i++) {
                    final newUser = User()
                      ..name = 'Jane Doe'
                      ..age = 36;
                    userList.add(newUser);
                  }
                  await isar.writeTxn(() async {
                    await isar.users.putAll(userList); // 将新用户数据写入到 Isar
                  });
                  users.value = isar.users.where().findAllSync();
                  loading.value = false;
                },
          child: const Text('插入用户'),
        ),
        SizedBox(
          height: 500,
          child: buildCupertinoScrollbar(
            child: SuperListView.builder(
              itemCount: users.value.length,
              itemBuilder: (context, index) => buildListTileWidget(
                context,
                title: '${users.value[index].id} - ${users.value[index].name}',
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
