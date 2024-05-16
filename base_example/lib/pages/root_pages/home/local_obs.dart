import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:base_example/global.dart';

class UserModel extends ModelSerialize {
  UserModel({this.name, this.age});

  String? name;
  int? age;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        age: DartUtil.safeInt(json['age']),
      );

  @override
  UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {'name': name, 'age': age};

  @override
  String toString() => 'User{name: $name, age: $age}';
}

class _Controller extends GetxController {
  late final count1 = useLocalObs(0, 'count1');
  late final count2 = useLocalObs(0, 'count2', expire: 10000);
  late final dynamicVar = useLocalObs<dynamic>(0, 'dynamic_var');
  late final userMap1 = useLocalObs<Map<dynamic, dynamic>>({'name': 'luoyi', 'age': 20}, 'user_map1');
  late final userMap2 = useLocalObs({'name': 'luoyi', 'age': 20, 1: 'hihi', 1.5: false}, 'user_map2');
  late final userMap3 = useLocalObs({
    'key': 1,
    'value': {
      'user': 'luoyi',
      'age': 20,
      // 1: 'hihi',
    },
  }, 'user_map3');
  late final userModel = useLocalObs(UserModel(), 'user_model');
}

class LocalObsPage extends HookWidget {
  const LocalObsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = useGetx(_Controller());
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地响应式变量'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                c.count1.value++;
              },
              child: Obx(() => Text('count1: ${c.count1.value}')),
            ),
            const Text('-----10秒后刷新过期------'),
            ElevatedButton(
              onPressed: () {
                c.count2.value++;
              },
              child: Obx(() => Text('count2: ${c.count2.value}')),
            ),
            const Text('-----动态变量------'),
            ElevatedButton(
              onPressed: () {
                c.dynamicVar.value++;
              },
              child: Obx(() => Text('dynamicVar: ${c.dynamicVar.value}')),
            ),
            const Text('-----响应式Model------'),
            ElevatedButton(
              onPressed: () {
                c.userModel.value = UserModel(
                  name: faker.person.firstName(),
                  age: Random().nextInt(100000),
                );
              },
              child: Obx(() => Text(c.userModel.value.toString())),
            ),
            const Text('-----响应式Map对象1------'),
            ElevatedButton(
              onPressed: () {
                c.userMap1.value = {
                  'name': faker.person.firstName(),
                  'age': Random().nextInt(100000),
                };
              },
              child: Obx(() => Text('userMap: ${c.userMap1.value}')),
            ),
            const Text('-----响应式Map对象2------'),
            ElevatedButton(
              onPressed: () {
                c.userMap2.value = {
                  'name': faker.person.firstName(),
                  'age': Random().nextInt(100000),
                  1: faker.person.firstName(),
                  1.5: !(c.userMap2.value[1.5] == true),
                };
              },
              child: Obx(() => Text('userMap: ${c.userMap2.value}')),
            ),
            const Text('-----响应式Map对象3------'),
            ElevatedButton(
              onPressed: () {
                int count = c.userMap3.value['key']! as int;
                c.userMap3.value = {
                  'key': count++,
                  'value': {
                    'name': faker.person.firstName(),
                    'age': Random().nextInt(100000),
                    // 1: faker.person.firstName(),
                  },
                };
              },
              child: Obx(() => Text('userMap: ${c.userMap3.value}')),
            ),
          ],
        ),
      ),
    );
  }
}
