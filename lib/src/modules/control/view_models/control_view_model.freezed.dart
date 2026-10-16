// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ControlState {

 LightState get light; LightConnection get connection;
/// Create a copy of ControlState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ControlStateCopyWith<ControlState> get copyWith => _$ControlStateCopyWithImpl<ControlState>(this as ControlState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ControlState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ControlState&&(identical(other.light, _this.light) || other.light == _this.light)&&(identical(other.connection, _this.connection) || other.connection == _this.connection));
}


@override
int get hashCode {
  final _this = this as ControlState;
  return Object.hash(runtimeType,_this.light,_this.connection);
}

@override
String toString() {
  final _this = this as ControlState;
  return 'ControlState(light: ${_this.light}, connection: ${_this.connection})';
}


}

/// @nodoc
abstract mixin class $ControlStateCopyWith<$Res>  {
  factory $ControlStateCopyWith(ControlState value, $Res Function(ControlState) _then) = _$ControlStateCopyWithImpl;
@useResult
$Res call({
 LightState light, LightConnection connection
});


$LightStateCopyWith<$Res> get light;$LightConnectionCopyWith<$Res> get connection;

}
/// @nodoc
class _$ControlStateCopyWithImpl<$Res>
    implements $ControlStateCopyWith<$Res> {
  _$ControlStateCopyWithImpl(this._self, this._then);

  final ControlState _self;
  final $Res Function(ControlState) _then;

/// Create a copy of ControlState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? light = null,Object? connection = null,}) {
  return _then(ControlState(
null == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as LightState,null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as LightConnection,
  ));
}
/// Create a copy of ControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LightStateCopyWith<$Res> get light {
  
  return $LightStateCopyWith<$Res>(_self.light, (value) {
    return _then(_self.copyWith(light: value));
  });
}/// Create a copy of ControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LightConnectionCopyWith<$Res> get connection {
  
  return $LightConnectionCopyWith<$Res>(_self.connection, (value) {
    return _then(_self.copyWith(connection: value));
  });
}
}


/// Adds pattern-matching-related methods to [ControlState].
extension ControlStatePatterns on ControlState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ControlState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ControlState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ControlState value)  $default,){
final _that = this;
switch (_that) {
case _ControlState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ControlState value)?  $default,){
final _that = this;
switch (_that) {
case _ControlState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LightState light,  LightConnection connection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ControlState() when $default != null:
return $default(_that.light,_that.connection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LightState light,  LightConnection connection)  $default,) {final _that = this;
switch (_that) {
case _ControlState():
return $default(_that.light,_that.connection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LightState light,  LightConnection connection)?  $default,) {final _that = this;
switch (_that) {
case _ControlState() when $default != null:
return $default(_that.light,_that.connection);case _:
  return null;

}
}

}

/// @nodoc


class _ControlState extends ControlState {
  const _ControlState(this.light, this.connection): super._();
  

@override final  LightState light;
@override final  LightConnection connection;

/// Create a copy of ControlState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ControlStateCopyWith<_ControlState> get copyWith => __$ControlStateCopyWithImpl<_ControlState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ControlState&&(identical(other.light, light) || other.light == light)&&(identical(other.connection, connection) || other.connection == connection));
}


@override
int get hashCode {
    return Object.hash(runtimeType,light,connection);
}

@override
String toString() {
    return 'ControlState(light: $light, connection: $connection)';
}


}

/// @nodoc
abstract mixin class _$ControlStateCopyWith<$Res> implements $ControlStateCopyWith<$Res> {
  factory _$ControlStateCopyWith(_ControlState value, $Res Function(_ControlState) _then) = __$ControlStateCopyWithImpl;
@override @useResult
$Res call({
 LightState light, LightConnection connection
});


@override $LightStateCopyWith<$Res> get light;@override $LightConnectionCopyWith<$Res> get connection;

}
/// @nodoc
class __$ControlStateCopyWithImpl<$Res>
    implements _$ControlStateCopyWith<$Res> {
  __$ControlStateCopyWithImpl(this._self, this._then);

  final _ControlState _self;
  final $Res Function(_ControlState) _then;

/// Create a copy of ControlState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? light = null,Object? connection = null,}) {
  return _then(_ControlState(
null == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as LightState,null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as LightConnection,
  ));
}

/// Create a copy of ControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LightStateCopyWith<$Res> get light {
  
  return $LightStateCopyWith<$Res>(_self.light, (value) {
    return _then(_self.copyWith(light: value));
  });
}/// Create a copy of ControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LightConnectionCopyWith<$Res> get connection {
  
  return $LightConnectionCopyWith<$Res>(_self.connection, (value) {
    return _then(_self.copyWith(connection: value));
  });
}
}

// dart format on
