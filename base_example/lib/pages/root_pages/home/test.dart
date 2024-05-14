import 'package:base_example/global.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试页面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final userModel = UserModel();
            final data = demo(userModel);
            i(data);
          },
          child: const Text('获取变量的真实类型'),
        ),
      ),
    );
  }

  dynamic demo<T>(T v) {
    if (v is BaseModel) {
      return v.fromJson({'name': 'luoyi', 'age': 20});
    } else {
      return null;
    }
  }
}

abstract class BaseModel {
  BaseModel fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

class UserModel extends BaseModel {
  String? name;
  int? age;

  UserModel({this.name, this.age});

  @override
  BaseModel fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        age: json['age'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
      };

  @override
  String toString() {
    return 'UserModel{name: $name, age: $age}';
  }
}
