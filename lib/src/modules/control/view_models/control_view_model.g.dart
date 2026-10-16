// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Everything the control screen can do to the light.

@ProviderFor(ControlViewModel)
final controlViewModelProvider = ControlViewModelProvider._();

/// Everything the control screen can do to the light.
final class ControlViewModelProvider extends $NotifierProvider<ControlViewModel, ControlState> {
  /// Everything the control screen can do to the light.
  ControlViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controlViewModelHash();

  @$internal
  @override
  ControlViewModel create() => ControlViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ControlState value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<ControlState>(value));
  }
}

String _$controlViewModelHash() => r'd389c184e36d6f9df50f824d7c6f9a9fb69f74aa';

/// Everything the control screen can do to the light.

abstract class _$ControlViewModel extends $Notifier<ControlState> {
  ControlState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ControlState, ControlState>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<ControlState, ControlState>, ControlState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
