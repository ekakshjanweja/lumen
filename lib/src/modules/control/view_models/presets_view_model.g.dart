// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presets_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's saved colours: listing, saving and deleting them.

@ProviderFor(PresetsViewModel)
final presetsViewModelProvider = PresetsViewModelProvider._();

/// The user's saved colours: listing, saving and deleting them.
final class PresetsViewModelProvider extends $NotifierProvider<PresetsViewModel, PresetsState> {
  /// The user's saved colours: listing, saving and deleting them.
  PresetsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'presetsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$presetsViewModelHash();

  @$internal
  @override
  PresetsViewModel create() => PresetsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PresetsState value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<PresetsState>(value));
  }
}

String _$presetsViewModelHash() => r'baabe4bcacdf91dd06c8363b47fa16b0d052b69a';

/// The user's saved colours: listing, saving and deleting them.

abstract class _$PresetsViewModel extends $Notifier<PresetsState> {
  PresetsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PresetsState, PresetsState>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<PresetsState, PresetsState>, PresetsState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
