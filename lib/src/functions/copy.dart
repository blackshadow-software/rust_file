import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:isolate';
import 'package:ffi/ffi.dart' as package_ffi;
import 'package:flutter/services.dart';
import '../init.dart';

typedef FastCopyFunc = PointerType Function(PointerType src, PointerType dest);
typedef PointerType = ffi.Pointer<package_ffi.Utf8>;

final FastCopyFunc _copy = dylib.lookup<ffi.NativeFunction<FastCopyFunc>>('fast_copy').asFunction<FastCopyFunc>();

Future<String> fastCopyDart(String src, String dest) async {
  final PointerType srcPtr = src.toNativeUtf8();
  final PointerType destPtr = dest.toNativeUtf8();

  final PointerType resultPtr = _copy(srcPtr.cast(), destPtr.cast());

  final result = resultPtr.toDartString();
  package_ffi.calloc.free(srcPtr);
  package_ffi.calloc.free(destPtr);

  return result;
}

Future<(String?, String?)> fastCopyIsolate(String src, String dest) async {
  final receivePort = ReceivePort();
  String? result, err;

  final completer = Completer<(String?, String?)>();
  await Isolate.spawn((List m) async {
    // await appConfigDBSync(m.last as RootIsolateToken);
    SendPort sendPort = m[0] as SendPort;
    final src = m[2] as String;
    final dest = m[3] as String;
    sendPort.send('$src -> $dest');

    return sendPort.send('l');
  }, [receivePort.sendPort, ServicesBinding.rootIsolateToken!, src, dest]);
  receivePort.listen((message) {
    if (message is String) {
      result = message;
      print(result);
    } else {
      err = 'invalid message';
      print(err);
    }

    receivePort.close();
    completer.complete((err, result));
  });

  return (await completer.future);
}
