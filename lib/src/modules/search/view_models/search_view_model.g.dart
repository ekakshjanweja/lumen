// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Finds the light by making it react, since channel lights never show up
/// in a Bluetooth scan:
/// 1. blink the factory-default channel and ask the user to confirm;
/// 2. otherwise sweep every channel and group, turning the light red;
/// 3. narrow down by flashing the last few candidates one at a time.

@ProviderFor(SearchViewModel)
final searchViewModelProvider = SearchViewModelProvider._();

/// Finds the light by making it react, since channel lights never show up
/// in a Bluetooth scan:
/// 1. blink the factory-default channel and ask the user to confirm;
/// 2. otherwise sweep every channel and group, turning the light red;
/// 3. narrow down by flashing the last few candidates one at a time.
final class SearchViewModelProvider extends $NotifierProvider<SearchViewModel, SearchState> {
  /// Finds the light by making it react, since channel lights never show up
  /// in a Bluetooth scan:
  /// 1. blink the factory-default channel and ask the user to confirm;
  /// 2. otherwise sweep every channel and group, turning the light red;
  /// 3. narrow down by flashing the last few candidates one at a time.
  SearchViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchViewModelHash();

  @$internal
  @override
  SearchViewModel create() => SearchViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchState value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<SearchState>(value));
  }
}

String _$searchViewModelHash() => r'2907de4303ce85305808f62e708d81ab9622c5e0';

/// Finds the light by making it react, since channel lights never show up
/// in a Bluetooth scan:
/// 1. blink the factory-default channel and ask the user to confirm;
/// 2. otherwise sweep every channel and group, turning the light red;
/// 3. narrow down by flashing the last few candidates one at a time.

abstract class _$SearchViewModel extends $Notifier<SearchState> {
  SearchState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SearchState, SearchState>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<SearchState, SearchState>, SearchState, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
