void main() {
  Demo1.name = 'xx';
  print(Demo1.name);
  print(Demo.name);
  // runApp(const _App());
}

class Demo {
  static String name = 'luoyi';
}

class Demo1 {
  static String _name = Demo.name;

  static String get name => _name;

  static set name(String v) {
    _name = v;
    Demo.name = v;
  }
}
