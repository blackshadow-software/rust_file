import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as package_ffi;
import '../init.dart';

final FastCopyDart fastCopy = dylib.lookup<ffi.NativeFunction<FastCopyNative>>('fast_copy').asFunction<FastCopyDart>();

typedef FastCopyNative = ffi.Pointer<package_ffi.Utf8> Function(
    ffi.Pointer<package_ffi.Utf8> src, ffi.Pointer<package_ffi.Utf8> dest);
typedef FastCopyDart = ffi.Pointer<package_ffi.Utf8> Function(
    ffi.Pointer<package_ffi.Utf8> src, ffi.Pointer<package_ffi.Utf8> dest);

Future<String> fastCopyDart(String src, String dest) async {
  final ffi.Pointer<package_ffi.Utf8> srcPtr = src.toNativeUtf8();
  final ffi.Pointer<package_ffi.Utf8> destPtr = dest.toNativeUtf8();

  final ffi.Pointer<package_ffi.Utf8> resultPtr = fastCopy(srcPtr.cast(), destPtr.cast());

  final result = resultPtr.toDartString();
  package_ffi.calloc.free(srcPtr);
  package_ffi.calloc.free(destPtr);
  // package_ffi.calloc.free(resultPtr);

  return result;
}
