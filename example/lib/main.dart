import 'dart:io';
import 'package:rust_file/rust_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'main.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MaterialApp(home: Home())));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Rust File')),
        body: const Column(children: [
          CopyExample(),
        ]));
  }
}

class CopyExample extends ConsumerWidget {
  const CopyExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(copyProvider('file'));
    final dir = ref.watch(copyProvider('dir'));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: decoration('From File Path'),
                  controller: ref.watch(textCtrlProvider('From File Path')),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10), child: Text('Copy To')),
              Expanded(
                child: TextField(
                  decoration: decoration('To File Path'),
                  controller: ref.watch(textCtrlProvider('To File Path')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: FilledButton.icon(
                    onPressed: () async {
                      final err = await ref.read(copyProvider('file').notifier).copyFile();
                      if (err != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
                      }
                    }, // ? copy file
                    label: const Text('Copy')),
              ),
              if (file != null) Text('$file ms taken')
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: decoration('From Directory Path'),
                  controller: ref.watch(textCtrlProvider('From Directory Path')),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10), child: Text('Copy To')),
              Expanded(
                child: TextField(
                  decoration: decoration('To Directory Path'),
                  controller: ref.watch(textCtrlProvider('To Directory Path')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: FilledButton.icon(
                    onPressed: () async => await ref.read(copyProvider('dir').notifier).copyDir(), // ? copy file
                    label: const Text('Copy')),
              ),
              if (dir != null) Text('$dir ms taken')
            ],
          ),
        ],
      ),
    );
  }
}

InputDecoration decoration(String hintText) => InputDecoration(hintText: hintText, border: const OutlineInputBorder());

/// ? ------ Providers ------
@riverpod
class TextCtrl extends _$TextCtrl {
  @override
  TextEditingController build(String e) => TextEditingController();
  void clear() => state.clear();
}

@riverpod
class Copy extends _$Copy {
  @override
  int? build(String f) => null;

  Future<String?> copyFile() async {
    final f = ref.read(textCtrlProvider('From File Path')).text.trim();
    final t = ref.read(textCtrlProvider('To File Path')).text.trim();
    final from = File(f);
    final to = File('/Users/remon/Rust/untitled folder/test.txt');
    try {
      final stopwatch = Stopwatch()..start();
      // await from.fastCopy(to);
      if (!await to.exists()) {
        await to.create();
      }
      await to.writeAsString('contents');
      stopwatch.stop();
      state = stopwatch.elapsedMilliseconds;
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<void> copyDir() async {}
}


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:rust_file/rust_file.dart' as rust_file;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late int sumResult;
//   late Future<int> sumAsyncResult;

//   @override
//   void initState() {
//     super.initState();
//     sumResult = rust_file.sum(1, 2);
//     sumAsyncResult = rust_file.sumAsync(3, 4);
//   }

//   @override
//   Widget build(BuildContext context) {
//     const textStyle = TextStyle(fontSize: 25);
//     const spacerSmall = SizedBox(height: 10);
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Native Packages'),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 const Text(
//                   'This calls a native function through FFI that is shipped as source in the package. '
//                   'The native code is built as part of the Flutter Runner build.',
//                   style: textStyle,
//                   textAlign: TextAlign.center,
//                 ),
//                 spacerSmall,
//                 Text(
//                   'sum(1, 2) = $sumResult',
//                   style: textStyle,
//                   textAlign: TextAlign.center,
//                 ),
//                 spacerSmall,
//                 FutureBuilder<int>(
//                   future: sumAsyncResult,
//                   builder: (BuildContext context, AsyncSnapshot<int> value) {
//                     final displayValue = (value.hasData) ? value.data : 'loading';
//                     return Text(
//                       'await sumAsync(3, 4) = $displayValue',
//                       style: textStyle,
//                       textAlign: TextAlign.center,
//                     );
//                   },
//                 ),
//                 const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             try {
//               final r = await File('/home/remon/Office/rust_file/example/test/widget_test.dart')
//                   .fastCopy('/home/remon/Office/rust_file/example/test/widget_test_3.dart');
//               debugPrint('Cipied : $r');
//             } catch (e) {
//               print(e);
//             }
//           },
//           child: const Icon(Icons.refresh),
//         ),
//       ),
//     );
//   }
// }
 
  