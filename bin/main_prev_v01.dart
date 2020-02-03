//import 'package:dart_console/dart_console.dart' as dart_console;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math' as math;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:mirrors';

main(List<String> arguments) async {
  //print('Hello world: ${dart_console.calculate()}!');

  // dart:core
  // Numbers
  var string = "Nice to meet you";

  assert(66 == int.parse("42", radix: 16));
  assert("3.14" == math.pi.toStringAsFixed(2));
  assert(string.contains("you"));
  assert("you" == string.substring(13, 16));
  assert(4 == string.split(" ").length);

  assert("NICE TO MEET YOU" == "Nice to meet you".toUpperCase());
  assert(!"   ".isEmpty);

  assert("AA bb CC bb" == "AA 123 CC 456".replaceAll(new RegExp(r"\d+"), "bb"));

  var sb = StringBuffer();
  sb.write("Nice ");
  sb.writeAll(["to ", "meet ", "you"]);
  assert(string == sb.toString());

  // Collections
  var list = <String>["apple", "banana", "orange"];
  assert(3 == list.length);

  list.sort((a, b) => b.compareTo(a));
  assert("orange" == list[0]);
  assert(list[0] is String);

  // Sets
  var set = Set.from(list);
  set.addAll(["dog", "cat", "bird"]);
  assert(6 == set.length);

  // Maps
  var map = <String, String>{
    "apple": "bird",
    "banana": "cat",
    "orange": "dog",
  };
  map.remove("orange");
  map.putIfAbsent("pear", () => "tiger");
  assert(3 == map.length);

  for(var string in map.keys) {
    //print(string);
  }

  // URIs
  var uri = 'https://example.org/api?foo=some message';
  var encodedString = Uri.encodeFull(uri);
  assert('https://example.org/api?foo=some%20message' == encodedString);
  assert(uri == Uri.decodeFull(encodedString));

  encodedString = Uri.encodeComponent(uri);
  assert('https%3A%2F%2Fexample.org%2Fapi%3Ffoo%3Dsome%20message' == encodedString);
  assert(uri == Uri.decodeComponent(encodedString));

  var uriObject = Uri.parse(uri);
  assert('https' == uriObject.scheme);
  assert('example.org' == uriObject.host);
  assert(443 == uriObject.port);
  assert('/api' == uriObject.path);

  uriObject = Uri(scheme: 'https', host: 'example.org', path: '/foo/bar', fragment: 'frag');
  assert('https://example.org/foo/bar#frag' == uriObject.toString());

  // Dates and times
  var current = DateTime.now();
  assert(2019 == current.year);
  var year2019 = DateTime(2019);
  assert(2019 == year2019.year);
  var date = DateTime(2019, 5, 9);
  assert(5 == date.month);
  date = DateTime.parse('2019-05-09T00:00:00Z');
  assert(9 == date.day);

  year2019 = DateTime.utc(2019);
  var year2020 = year2019.add(const Duration(days: 366));
  assert(2020 == year2020.year);

  var year2018 = year2019.subtract(const Duration(days: 30));
  assert(2018 == year2018.year);

  var diff = year2019.difference(year2018);
  assert(30 == diff.inDays);

  // Utility classes
  var p1 = Person('Nick', 'West');
  var p2 = Person('Nick', 'West');
  var p3 = 'not a person';
  assert(p1.hashCode == p2.hashCode);
  assert(p1 == p2);
  /*assert(p1 != p3);*/

  // dart:async
  final StreamController controller = StreamController();
  ///*final StreamSubscription subscription = */controller.stream.listen((data) => print('$data'));

  controller.sink.add('my name');
  controller.sink.add(1234);
  controller.sink.add({'a': 'element A', 'b': 'element B'});

  controller.close();

  // Future
  var html = await getHtml();
  assert('' != html);

  // dart:math
  assert(-1.0 == math.cos(math.pi));
  assert(100 == math.max(1, 100));
  assert(-100 == math.min(1, -100));
  //print(math.e);
  var random = math.Random();
  assert(101 != random.nextInt(100));

  // WebSocket
  var channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  channel.sink.add('connected!');

  channel.stream.listen((message) {
    //print(message);

    channel.sink.close(status.goingAway);
  });

  // dart:io
  // 1.Writing file contents
  var testFile = File('test.log');
  var sink = testFile.openWrite();
  sink.write('hello flutter\nhello world');
  sink.close();

  // 2.Reading a file as text
  var content = await testFile.readAsString();
  assert('' != content);

  // 3.Streaming file contents
  Stream<List<int>> input = testFile.openRead();
  var lines = input
      .transform(utf8.decoder)
      .transform(LineSplitter());
  try {
    await for (var line in lines) {
      //print(line);
    }
  } catch (e) {
    print(e);
  }

  // 4.Listing files in a directory
  var dir = Directory('./');
  try {
    var dirList = dir.list();
    await for (FileSystemEntity f in dirList) {
      if (f is File) {
        //print('Fount file ${f.path}');
      } else {
        //print('Fount dir ${f.path}');
      }
    }

  } catch (e) {
    print(e);
  }

  // dart:convert
  // Decoding and encoding JSON
  var jsonString = '''
  [
    {"score": 77},
    {"score": 88}
  ]
  ''';
  var scores = jsonDecode(jsonString);
  assert(scores is List);
  assert(77 == scores[0]['score']);

  var userInfo = {
    'name': 'Aaric Thailad',
    'email': 'vapaaric@gmail.com'
  };
  var jsonText = jsonEncode(userInfo);
  assert('{"name":"Aaric Thailad","email":"vapaaric@gmail.com"}' == jsonText);

  // dart:mirrors
  const className = #getHtml;
  assert('getHtml' == MirrorSystem.getName(className));

  ClassMirror mirror1 = reflectClass(Person);
  assert('Person' == MirrorSystem.getName(mirror1.simpleName));

  var p = Person('Aaric', 'Thailad');
  ClassMirror mirror2 = reflectClass(p.runtimeType);
  assert('Person' == MirrorSystem.getName(mirror2.simpleName));

  InstanceMirror mirror3 = reflect(p);
  //mirror3.invoke(#hashCode, null);
}

// Future
getHtml() async {
  var html;
  HttpClient client = HttpClient();
  HttpClientRequest request = await client.getUrl(Uri.parse('https://www.baidu.com'));
  HttpClientResponse response = await request.close();
  if(HttpStatus.ok == response.statusCode) {
    html = await response.transform(utf8.decoder).join();
  }
  client.close();
  return html;
}

// Exceptions
class FooException implements Exception {
  final String msg;

  const FooException([this.msg]);

  String toString() => msg ?? 'FooException';
}

// Implementing map keys
class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);

  int get hashCode {
    int result = 17;
    result = 37 * result + firstName.hashCode;
    result = 37 * result + lastName.hashCode;
    return result;
  }

  bool operator ==(other) {
    if(other is! Person) {
      return false;
    }
    Person person = other;
    return person.firstName == firstName && person.lastName == lastName;
  }
}
