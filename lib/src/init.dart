import 'dart:io';
import 'dart:ffi' as ffi;
import 'utils/const.dart';

final ffi.DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return ffi.DynamicLibrary.open('$libName.framework/$libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return ffi.DynamicLibrary.open('lib$libName.so');
  }
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('$libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

final RustFileBindings bindings = RustFileBindings(_dylib);

class RustFileBindings {
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) _lookup;
  RustFileBindings(ffi.DynamicLibrary dynamicLibrary) : _lookup = dynamicLibrary.lookup;
  RustFileBindings.fromLookup(ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) lookup)
      : _lookup = lookup;

  int sum(
    int a,
    int b,
  ) {
    return _sum(
      a,
      b,
    );
  }

  late final _sumPtr = _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Int, ffi.Int)>>('sum');
  late final _sum = _sumPtr.asFunction<int Function(int, int)>();

  int sum_long_running(
    int a,
    int b,
  ) {
    return _sum_long_running(
      a,
      b,
    );
  }

  late final _sum_long_runningPtr = _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Int, ffi.Int)>>('sum_long_running');
  late final _sum_long_running = _sum_long_runningPtr.asFunction<int Function(int, int)>();
}
