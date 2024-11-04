import 'dart:io';

import '../functions/copy.dart';

extension FileExtension on File {
  String get name => path.split('/').last.split('\\').last;
  String get extension => path.split('.').last;
  String get nameWithoutExtension => name.replaceAll('.$extension', '');
  String get parent =>
      path.split('/').last.split('\\').sublist(0, path.split('/').last.split('\\').length - 1).join('/');
  String get pathWithoutExtension => '$parent/$nameWithoutExtension';
  String get pathWithExtension => '$parent/$name';
  String get pathWithNewExtension => '$parent/$nameWithoutExtension.$extension';
  String get pathWithNewName => '$parent/$nameWithoutExtension';

  Future<bool> fastCopy(String dest) async {
    final r = await fastCopyIsolate(path, dest);
    if (r.success == false) {
      return throw Exception(r.error);
    }
    return r.success ?? false;
  }

  Future<void> fastMove(String dest) async {}
  Future<void> fastDelete() async {}
}
