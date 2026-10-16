// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_gate_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppGateState {

 AppScreen get screen; bool get canTurnOnBluetooth;/// The permission can only be granted from system settings now.
 bool get needsSettings;
/// Create a copy of AppGateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppGateStateCopyWith<AppGateState> get copyWith => _$AppGateStateCopyWithImpl<AppGateState>(this as AppGateState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppGateState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppGateState&&(identical(other.screen, _this.screen) || other.screen == _this.screen)&&(identical(other.canTurnOnBluetooth, _this.canTurnOnBluetooth) || other.canTurnOnBluetooth == _this.canTurnOnBluetooth)&&(identical(other.needsSettings, _this.needsSettings) || other.needsSettings == _this.needsSettings));
}


@override
int get hashCode {
  final _this = this as AppGateState;
  return Object.hash(runtimeType,_this.screen,_this.canTurnOnBluetooth,_this.needsSettings);
}

@override
String toString() {
  final _this = this as AppGateState;
  return 'AppGateState(screen: ${_this.screen}, canTurnOnBluetooth: ${_this.canTurnOnBluetooth}, needsSettings: ${_this.needsSettings})';
}


}

/// @nodoc
abstract mixin class $AppGateStateCopyWith<$Res>  {
  factory $AppGateStateCopyWith(AppGateState value, $Res Function(AppGateState) _then) = _$AppGateStateCopyWithImpl;
@useResult
$Res call({
 AppScreen screen, bool canTurnOnBluetooth, bool needsSettings
});




}
/// @nodoc
class _$AppGateStateCopyWithImpl<$Res>
    implements $AppGateStateCopyWith<$Res> {
  _$AppGateStateCopyWithImpl(this._self, this._then);

  final AppGateState _self;
  final $Res Function(AppGateState) _then;

/// Create a copy of AppGateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? screen = null,Object? canTurnOnBluetooth = null,Object? needsSettings = null,}) {
  return _then(AppGateState(
null == screen ? _self.screen : screen // ignore: cast_nullable_to_non_nullable
as AppScreen,canTurnOnBluetooth: null == canTurnOnBluetooth ? _self.canTurnOnBluetooth : canTurnOnBluetooth // ignore: cast_nullable_to_non_nullable
as bool,needsSettings: null == needsSettings ? _self.needsSettings : needsSettings // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppGateState].
extension AppGateStatePatterns on AppGateState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppGateState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppGateState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppGateState value)  $default,){
final _that = this;
switch (_that) {
case _AppGateState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppGateState value)?  $default,){
final _that = this;
switch (_that) {
case _AppGateState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppScreen screen,  bool canTurnOnBluetooth,  bool needsSettings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppGateState() when $default != null:
return $default(_that.screen,_that.canTurnOnBluetooth,_that.needsSettings);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppScreen screen,  bool canTurnOnBluetooth,  bool needsSettings)  $default,) {final _that = this;
switch (_that) {
case _AppGateState():
return $default(_that.screen,_that.canTurnOnBluetooth,_that.needsSettings);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppScreen screen,  bool canTurnOnBluetooth,  bool needsSettings)?  $default,) {final _that = this;
switch (_that) {
case _AppGateState() when $default != null:
return $default(_that.screen,_that.canTurnOnBluetooth,_that.needsSettings);case _:
  return null;

}
}

}

/// @nodoc


class _AppGateState implements AppGateState {
  const _AppGateState(this.screen, {this.canTurnOnBluetooth = false, this.needsSettings = false});
  

@override final  AppScreen screen;
@override@JsonKey() final  bool canTurnOnBluetooth;
/// The permission can only be granted from system settings now.
@override@JsonKey() final  bool needsSettings;

/// Create a copy of AppGateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppGateStateCopyWith<_AppGateState> get copyWith => __$AppGateStateCopyWithImpl<_AppGateState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppGateState&&(identical(other.screen, screen) || other.screen == screen)&&(identical(other.canTurnOnBluetooth, canTurnOnBluetooth) || other.canTurnOnBluetooth == canTurnOnBluetooth)&&(identical(other.needsSettings, needsSettings) || other.needsSettings == needsSettings));
}


@override
int get hashCode {
    return Object.hash(runtimeType,screen,canTurnOnBluetooth,needsSettings);
}

@override
String toString() {
    return 'AppGateState(screen: $screen, canTurnOnBluetooth: $canTurnOnBluetooth, needsSettings: $needsSettings)';
}


}

/// @nodoc
abstract mixin class _$AppGateStateCopyWith<$Res> implements $AppGateStateCopyWith<$Res> {
  factory _$AppGateStateCopyWith(_AppGateState value, $Res Function(_AppGateState) _then) = __$AppGateStateCopyWithImpl;
@override @useResult
$Res call({
 AppScreen screen, bool canTurnOnBluetooth, bool needsSettings
});




}
/// @nodoc
class __$AppGateStateCopyWithImpl<$Res>
    implements _$AppGateStateCopyWith<$Res> {
  __$AppGateStateCopyWithImpl(this._self, this._then);

  final _AppGateState _self;
  final $Res Function(_AppGateState) _then;

/// Create a copy of AppGateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? screen = null,Object? canTurnOnBluetooth = null,Object? needsSettings = null,}) {
  return _then(_AppGateState(
null == screen ? _self.screen : screen // ignore: cast_nullable_to_non_nullable
as AppScreen,canTurnOnBluetooth: null == canTurnOnBluetooth ? _self.canTurnOnBluetooth : canTurnOnBluetooth // ignore: cast_nullable_to_non_nullable
as bool,needsSettings: null == needsSettings ? _self.needsSettings : needsSettings // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
