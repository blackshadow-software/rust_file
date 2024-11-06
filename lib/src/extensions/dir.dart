import 'dart:io';

import '../functions/copy.dart';

extension DirExtension on Directory {
  Future<bool> fastCopy(Directory dest) async {
    final r = await fastCopyIsolate(path, dest.path);
    if (r.success == false) {
      return throw Exception(r.error);
    }
    return r.success ?? false;
  }

  Future<void> fastMove(Directory dest) async {}
  Future<void> fastDelete() async {}
}
