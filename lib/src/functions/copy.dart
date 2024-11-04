import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as package_ffi;
import '../init.dart';

typedef FastCopy = PointerType Function(PointerType src, PointerType dest);
typedef PointerType = ffi.Pointer<package_ffi.Utf8>;

final FastCopy fastCopy = dylib.lookup<ffi.NativeFunction<FastCopy>>('fast_copy').asFunction<FastCopy>();

Future<String> fastCopyDart(String src, String dest) async {
  final PointerType srcPtr = src.toNativeUtf8();
  final PointerType destPtr = dest.toNativeUtf8();

  final PointerType resultPtr = fastCopy(srcPtr.cast(), destPtr.cast());

  final result = resultPtr.toDartString();
  package_ffi.calloc.free(srcPtr);
  package_ffi.calloc.free(destPtr); 

  return result;
}
