// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_gate_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Decides which top-level screen to show.

@ProviderFor(AppGateViewModel)
final appGateViewModelProvider = AppGateViewModelProvider._();

/// Decides which top-level screen to show.
final class AppGateViewModelProvider extends $NotifierProvider<AppGateViewModel, AppGateState> {
  /// Decides which top-level screen to show.
  AppGateViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appGateViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appGateViewModelHash();

  @$internal
  @override
  AppGateViewModel create() => AppGateViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppGateState value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AppGateState>(value));
  }
}

String _$appGateViewModelHash() => r'191df9765a9e9cdc4ee89fd07bd0244e6788ae95';

/// Decides which top-level screen to show.

abstract class _$AppGateViewModel extends $Notifier<AppGateState> {
  AppGateState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppGateState, AppGateState>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<AppGateState, AppGateState>, AppGateState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
