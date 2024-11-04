import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:isolate';
import 'package:ffi/ffi.dart' as package_ffi;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rust_file/src/models/model.dart';
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

Future<Response> fastCopyIsolate(String src, String dest) async {
  final receivePort = ReceivePort();
  Response? result;

  final completer = Completer<Response>();
  await Isolate.spawn((List m) async {
    SendPort sendPort = m[0] as SendPort;
    try {
      final src = m[2] as String;
      final dest = m[3] as String;
      final r = await fastCopyDart(src, dest);
      print('0 $r ');
      final result = Response.fromRawJson(r);
      print('1 ${result.toString()}');
      return sendPort.send(result);
    } catch (e) {
      print(e);

      return sendPort.send(e.toString());
    }
  }, [receivePort.sendPort, ServicesBinding.rootIsolateToken!, src, dest]);
  receivePort.listen((message) {
    print('2 $message');

    if (message is Response) {
      result = message;
      debugPrint(result.toString());
    } else {
      result = Response(success: false, error: 'Something went wrong from thread!');
      debugPrint(result.toString());
    }

    receivePort.close();
    completer.complete(result);
  });

  return (await completer.future);
}
