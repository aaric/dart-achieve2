// 0.2.0-SNAPSHOT Dart Language

void main(List<String> arguments) {
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
