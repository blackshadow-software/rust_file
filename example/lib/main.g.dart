// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$textCtrlHash() => r'b927aec5d1eb281f647f6b4ad7c2135becc28588';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TextCtrl
    extends BuildlessAutoDisposeNotifier<TextEditingController> {
  late final String e;

  TextEditingController build(
    String e,
  );
}

/// ? ------ Providers ------
///
/// Copied from [TextCtrl].
@ProviderFor(TextCtrl)
const textCtrlProvider = TextCtrlFamily();

/// ? ------ Providers ------
///
/// Copied from [TextCtrl].
class TextCtrlFamily extends Family<TextEditingController> {
  /// ? ------ Providers ------
  ///
  /// Copied from [TextCtrl].
  const TextCtrlFamily();

  /// ? ------ Providers ------
  ///
  /// Copied from [TextCtrl].
  TextCtrlProvider call(
    String e,
  ) {
    return TextCtrlProvider(
      e,
    );
  }

  @override
  TextCtrlProvider getProviderOverride(
    covariant TextCtrlProvider provider,
  ) {
    return call(
      provider.e,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'textCtrlProvider';
}

/// ? ------ Providers ------
///
/// Copied from [TextCtrl].
class TextCtrlProvider
    extends AutoDisposeNotifierProviderImpl<TextCtrl, TextEditingController> {
  /// ? ------ Providers ------
  ///
  /// Copied from [TextCtrl].
  TextCtrlProvider(
    String e,
  ) : this._internal(
          () => TextCtrl()..e = e,
          from: textCtrlProvider,
          name: r'textCtrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$textCtrlHash,
          dependencies: TextCtrlFamily._dependencies,
          allTransitiveDependencies: TextCtrlFamily._allTransitiveDependencies,
          e: e,
        );

  TextCtrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.e,
  }) : super.internal();

  final String e;

  @override
  TextEditingController runNotifierBuild(
    covariant TextCtrl notifier,
  ) {
    return notifier.build(
      e,
    );
  }

  @override
  Override overrideWith(TextCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: TextCtrlProvider._internal(
        () => create()..e = e,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        e: e,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TextCtrl, TextEditingController>
      createElement() {
    return _TextCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TextCtrlProvider && other.e == e;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, e.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TextCtrlRef on AutoDisposeNotifierProviderRef<TextEditingController> {
  /// The parameter `e` of this provider.
  String get e;
}

class _TextCtrlProviderElement
    extends AutoDisposeNotifierProviderElement<TextCtrl, TextEditingController>
    with TextCtrlRef {
  _TextCtrlProviderElement(super.provider);

  @override
  String get e => (origin as TextCtrlProvider).e;
}

String _$copyHash() => r'b9a0aba46c64a7fc1a37300b9ae95a60851633b3';

abstract class _$Copy extends BuildlessAutoDisposeNotifier<int?> {
  late final String f;

  int? build(
    String f,
  );
}

/// See also [Copy].
@ProviderFor(Copy)
const copyProvider = CopyFamily();

/// See also [Copy].
class CopyFamily extends Family<int?> {
  /// See also [Copy].
  const CopyFamily();

  /// See also [Copy].
  CopyProvider call(
    String f,
  ) {
    return CopyProvider(
      f,
    );
  }

  @override
  CopyProvider getProviderOverride(
    covariant CopyProvider provider,
  ) {
    return call(
      provider.f,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'copyProvider';
}

/// See also [Copy].
class CopyProvider extends AutoDisposeNotifierProviderImpl<Copy, int?> {
  /// See also [Copy].
  CopyProvider(
    String f,
  ) : this._internal(
          () => Copy()..f = f,
          from: copyProvider,
          name: r'copyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$copyHash,
          dependencies: CopyFamily._dependencies,
          allTransitiveDependencies: CopyFamily._allTransitiveDependencies,
          f: f,
        );

  CopyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.f,
  }) : super.internal();

  final String f;

  @override
  int? runNotifierBuild(
    covariant Copy notifier,
  ) {
    return notifier.build(
      f,
    );
  }

  @override
  Override overrideWith(Copy Function() create) {
    return ProviderOverride(
      origin: this,
      override: CopyProvider._internal(
        () => create()..f = f,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        f: f,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<Copy, int?> createElement() {
    return _CopyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CopyProvider && other.f == f;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, f.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CopyRef on AutoDisposeNotifierProviderRef<int?> {
  /// The parameter `f` of this provider.
  String get f;
}

class _CopyProviderElement
    extends AutoDisposeNotifierProviderElement<Copy, int?> with CopyRef {
  _CopyProviderElement(super.provider);

  @override
  String get f => (origin as CopyProvider).f;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
