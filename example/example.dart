import 'dart:ffi' as ffi;

import 'package:dylib/dylib.dart';

void main() {
  libfoo.bar();
}

LibFoo? _libfoo;
LibFoo get libfoo {
  return _libfoo ??= LibFoo(ffi.DynamicLibrary.open(
    resolveDylibPath(
      'foo', // foo.dll, libfoo.so, libfoo.dylib...
      dartDefine: 'LIBFOO_PATH',
      environmentVariable: 'LIBFOO_PATH',
    ),
  ));
}

// e.g. generated by ffigen
class LibFoo {
  final ffi.DynamicLibrary _dylib;
  LibFoo(this._dylib);

  int bar() {
    return (_foo_bar ??=
        _dylib.lookupFunction<_c_foo_bar, _dart_foo_bar>('foo_bar'))();
  }

  _dart_foo_bar? _foo_bar;
}

typedef _c_foo_bar = ffi.Int32 Function();
typedef _dart_foo_bar = int Function();
