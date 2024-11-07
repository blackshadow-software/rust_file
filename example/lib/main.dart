import 'dart:developer';
import 'dart:io' show Directory, File, Platform;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
                      await permission();
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
                    onPressed: () async {
                      await permission();
                      final err = await ref.read(copyProvider('dir').notifier).copyDir();
                      if (err != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
                      }
                    }, // ? copy dir
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
    final directory = await getExternalStorageDirectory();
    log(directory.toString());
    final f = ref.read(textCtrlProvider('From File Path')).text.trim();
    final t = ref.read(textCtrlProvider('To File Path')).text.trim();
    final from = File(f);
    final to = File(t);

    try {
      final stopwatch = Stopwatch()..start();
      await from.fastCopy(to);
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

  Future<String?> copyDir() async {
    final f = ref.read(textCtrlProvider('From Directory Path')).text.trim();
    final t = ref.read(textCtrlProvider('To Directory Path')).text.trim();
    final from = Directory(f);
    final to = Directory(t);

    try {
      final stopwatch = Stopwatch()..start();
      await from.fastCopy(to);
      stopwatch.stop();
      state = stopwatch.elapsedMilliseconds;
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }
}

Future<void> permission() async {
  switch (Platform.operatingSystem) {
    case 'android':
      if (!await Permission.storage.status.isGranted) {
        await Permission.storage.request();
      }
      break;
    case 'ios':
      break;
    case 'linux':
      break;
    case 'macos':
      break;
    case 'windows':
      break;
  }
}
