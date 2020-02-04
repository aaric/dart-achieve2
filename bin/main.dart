// 0.2.0-SNAPSHOT Dart Language
import 'package:http/http.dart' as http;
import 'dart:math' deferred as math;

void main(List<String> arguments) async {
  // 一、变量与常量
  var num = 1;
  const w1 = 100;
  const h1 = 50;
  const area = w1 * h1;
  final t1 = DateTime.now();
  /*const t2 = DateTime.now();*/ //error

  // 二、数据类型
  // 2.1 number: int, double
  var i1 = 1;
  var i2 = int.parse('2');
  var d1 = 1.0;
  var d2 = double.parse('2.0');
  // 2.2 String
  var s1 = 'hello world';
  // 2.3 bool
  var b1 = true;
  var b2 = 1 == 2;
  // 2.4 list
  var l1 = [1, 2 ,3];
  /*print(l1[0]);
  print(l1.first);
  print(l1.last);*/
  // 2.5 map
  var m1 = {'x': 1, 'y': 2, 'z': 3};
  /*print(m1['x']);*/

  // 三、函数
  var sum_1 = add_1(1, 2);
  var sum_2 = add_2(3);
  var sum_3 = add_3(a: 4, b: 5);
  // 匿名函数
  var numbers = [1, 2, 3];
  numbers.forEach((n) {
    /*print(n);*/
  });

  // 四、Class
  var p1 = Person(name: 'Aaric', age: 18);
  /*p1.sayHello();*/
  var p2 = Worker(name: 'Aaric', age: 18, salary: 2000);
  /*p2.sayHello();
  p2.wear();
  p2.equip();*/

  // 五、库
  /*print(await http.read('https://www.baidu.com'));*/
  await math.loadLibrary();
  var random = math.Random();
  /*print(random.nextInt(10));*/
}

abstract class Animal {
  void eat();
}

class Person extends Animal {
  String name;
  int age;

  Person({String name = '', int age = 0}) {
    this.name = name;
    this.age = age;
  }

  void sayHello() {
    print('Hello, ' + name);
  }

  @override
  void eat() {
    print('eat rice');
  }
}

class SafetyHat {
  void wear() {
    print('wear safety hat');
  }
}

class WorkTool {
  void equip() {
    print('get tool kit');
  }
}

class Worker extends Person with SafetyHat, WorkTool {
  int salary;

  Worker({String name = '', int age = 0, int salary = 0}) {
    this.name = name;
    this.age = age;
    this.salary = salary;
  }

  @override
  void sayHello() {
    print('Salary: ' + salary.toString());
  }
}

// 完整参数
int add_1(int a, int b) {
  return a + b;
}

// 缺省参数
int add_2(int a, [int b]) {
  return a + (b ?? 0);
}

// 默认值
int add_3({int a = 0, int b = 0}) {
  return a + b;
}
