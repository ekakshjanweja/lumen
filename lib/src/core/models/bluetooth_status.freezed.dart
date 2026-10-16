// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluetooth_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BluetoothStatus {

 AdapterStatus get adapter;/// The user declined the permission needed to broadcast to channel lights.
 bool get broadcastDenied;/// Whether the app can switch Bluetooth on itself (Android only).
 bool get canTurnOn;
/// Create a copy of BluetoothStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BluetoothStatusCopyWith<BluetoothStatus> get copyWith => _$BluetoothStatusCopyWithImpl<BluetoothStatus>(this as BluetoothStatus, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BluetoothStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BluetoothStatus&&(identical(other.adapter, _this.adapter) || other.adapter == _this.adapter)&&(identical(other.broadcastDenied, _this.broadcastDenied) || other.broadcastDenied == _this.broadcastDenied)&&(identical(other.canTurnOn, _this.canTurnOn) || other.canTurnOn == _this.canTurnOn));
}


@override
int get hashCode {
  final _this = this as BluetoothStatus;
  return Object.hash(runtimeType,_this.adapter,_this.broadcastDenied,_this.canTurnOn);
}

@override
String toString() {
  final _this = this as BluetoothStatus;
  return 'BluetoothStatus(adapter: ${_this.adapter}, broadcastDenied: ${_this.broadcastDenied}, canTurnOn: ${_this.canTurnOn})';
}


}

/// @nodoc
abstract mixin class $BluetoothStatusCopyWith<$Res>  {
  factory $BluetoothStatusCopyWith(BluetoothStatus value, $Res Function(BluetoothStatus) _then) = _$BluetoothStatusCopyWithImpl;
@useResult
$Res call({
 AdapterStatus adapter, bool broadcastDenied, bool canTurnOn
});




}
/// @nodoc
class _$BluetoothStatusCopyWithImpl<$Res>
    implements $BluetoothStatusCopyWith<$Res> {
  _$BluetoothStatusCopyWithImpl(this._self, this._then);

  final BluetoothStatus _self;
  final $Res Function(BluetoothStatus) _then;

/// Create a copy of BluetoothStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? adapter = null,Object? broadcastDenied = null,Object? canTurnOn = null,}) {
  return _then(BluetoothStatus(
adapter: null == adapter ? _self.adapter : adapter // ignore: cast_nullable_to_non_nullable
as AdapterStatus,broadcastDenied: null == broadcastDenied ? _self.broadcastDenied : broadcastDenied // ignore: cast_nullable_to_non_nullable
as bool,canTurnOn: null == canTurnOn ? _self.canTurnOn : canTurnOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BluetoothStatus].
extension BluetoothStatusPatterns on BluetoothStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BluetoothStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BluetoothStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BluetoothStatus value)  $default,){
final _that = this;
switch (_that) {
case _BluetoothStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BluetoothStatus value)?  $default,){
final _that = this;
switch (_that) {
case _BluetoothStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AdapterStatus adapter,  bool broadcastDenied,  bool canTurnOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BluetoothStatus() when $default != null:
return $default(_that.adapter,_that.broadcastDenied,_that.canTurnOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AdapterStatus adapter,  bool broadcastDenied,  bool canTurnOn)  $default,) {final _that = this;
switch (_that) {
case _BluetoothStatus():
return $default(_that.adapter,_that.broadcastDenied,_that.canTurnOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AdapterStatus adapter,  bool broadcastDenied,  bool canTurnOn)?  $default,) {final _that = this;
switch (_that) {
case _BluetoothStatus() when $default != null:
return $default(_that.adapter,_that.broadcastDenied,_that.canTurnOn);case _:
  return null;

}
}

}

/// @nodoc


class _BluetoothStatus implements BluetoothStatus {
  const _BluetoothStatus({this.adapter = AdapterStatus.unknown, this.broadcastDenied = false, this.canTurnOn = false});
  

@override@JsonKey() final  AdapterStatus adapter;
/// The user declined the permission needed to broadcast to channel lights.
@override@JsonKey() final  bool broadcastDenied;
/// Whether the app can switch Bluetooth on itself (Android only).
@override@JsonKey() final  bool canTurnOn;

/// Create a copy of BluetoothStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BluetoothStatusCopyWith<_BluetoothStatus> get copyWith => __$BluetoothStatusCopyWithImpl<_BluetoothStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BluetoothStatus&&(identical(other.adapter, adapter) || other.adapter == adapter)&&(identical(other.broadcastDenied, broadcastDenied) || other.broadcastDenied == broadcastDenied)&&(identical(other.canTurnOn, canTurnOn) || other.canTurnOn == canTurnOn));
}


@override
int get hashCode {
    return Object.hash(runtimeType,adapter,broadcastDenied,canTurnOn);
}

@override
String toString() {
    return 'BluetoothStatus(adapter: $adapter, broadcastDenied: $broadcastDenied, canTurnOn: $canTurnOn)';
}


}

/// @nodoc
abstract mixin class _$BluetoothStatusCopyWith<$Res> implements $BluetoothStatusCopyWith<$Res> {
  factory _$BluetoothStatusCopyWith(_BluetoothStatus value, $Res Function(_BluetoothStatus) _then) = __$BluetoothStatusCopyWithImpl;
@override @useResult
$Res call({
 AdapterStatus adapter, bool broadcastDenied, bool canTurnOn
});




}
/// @nodoc
class __$BluetoothStatusCopyWithImpl<$Res>
    implements _$BluetoothStatusCopyWith<$Res> {
  __$BluetoothStatusCopyWithImpl(this._self, this._then);

  final _BluetoothStatus _self;
  final $Res Function(_BluetoothStatus) _then;

/// Create a copy of BluetoothStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? adapter = null,Object? broadcastDenied = null,Object? canTurnOn = null,}) {
  return _then(_BluetoothStatus(
adapter: null == adapter ? _self.adapter : adapter // ignore: cast_nullable_to_non_nullable
as AdapterStatus,broadcastDenied: null == broadcastDenied ? _self.broadcastDenied : broadcastDenied // ignore: cast_nullable_to_non_nullable
as bool,canTurnOn: null == canTurnOn ? _self.canTurnOn : canTurnOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
