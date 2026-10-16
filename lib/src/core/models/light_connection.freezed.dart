// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'light_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LightConnection {

 PairedLight? get light; LinkStatus get status;
/// Create a copy of LightConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightConnectionCopyWith<LightConnection> get copyWith => _$LightConnectionCopyWithImpl<LightConnection>(this as LightConnection, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LightConnection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightConnection&&(identical(other.light, _this.light) || other.light == _this.light)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as LightConnection;
  return Object.hash(runtimeType,_this.light,_this.status);
}

@override
String toString() {
  final _this = this as LightConnection;
  return 'LightConnection(light: ${_this.light}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $LightConnectionCopyWith<$Res>  {
  factory $LightConnectionCopyWith(LightConnection value, $Res Function(LightConnection) _then) = _$LightConnectionCopyWithImpl;
@useResult
$Res call({
 PairedLight? light, LinkStatus status
});


$PairedLightCopyWith<$Res>? get light;

}
/// @nodoc
class _$LightConnectionCopyWithImpl<$Res>
    implements $LightConnectionCopyWith<$Res> {
  _$LightConnectionCopyWithImpl(this._self, this._then);

  final LightConnection _self;
  final $Res Function(LightConnection) _then;

/// Create a copy of LightConnection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? light = freezed,Object? status = null,}) {
  return _then(LightConnection(
freezed == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as PairedLight?,null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LinkStatus,
  ));
}
/// Create a copy of LightConnection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairedLightCopyWith<$Res>? get light {
    if (_self.light == null) {
    return null;
  }

  return $PairedLightCopyWith<$Res>(_self.light!, (value) {
    return _then(_self.copyWith(light: value));
  });
}
}


/// Adds pattern-matching-related methods to [LightConnection].
extension LightConnectionPatterns on LightConnection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LightConnection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LightConnection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LightConnection value)  $default,){
final _that = this;
switch (_that) {
case _LightConnection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LightConnection value)?  $default,){
final _that = this;
switch (_that) {
case _LightConnection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PairedLight? light,  LinkStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LightConnection() when $default != null:
return $default(_that.light,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PairedLight? light,  LinkStatus status)  $default,) {final _that = this;
switch (_that) {
case _LightConnection():
return $default(_that.light,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PairedLight? light,  LinkStatus status)?  $default,) {final _that = this;
switch (_that) {
case _LightConnection() when $default != null:
return $default(_that.light,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _LightConnection extends LightConnection {
  const _LightConnection(this.light, this.status): super._();
  

@override final  PairedLight? light;
@override final  LinkStatus status;

/// Create a copy of LightConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LightConnectionCopyWith<_LightConnection> get copyWith => __$LightConnectionCopyWithImpl<_LightConnection>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LightConnection&&(identical(other.light, light) || other.light == light)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,light,status);
}

@override
String toString() {
    return 'LightConnection(light: $light, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LightConnectionCopyWith<$Res> implements $LightConnectionCopyWith<$Res> {
  factory _$LightConnectionCopyWith(_LightConnection value, $Res Function(_LightConnection) _then) = __$LightConnectionCopyWithImpl;
@override @useResult
$Res call({
 PairedLight? light, LinkStatus status
});


@override $PairedLightCopyWith<$Res>? get light;

}
/// @nodoc
class __$LightConnectionCopyWithImpl<$Res>
    implements _$LightConnectionCopyWith<$Res> {
  __$LightConnectionCopyWithImpl(this._self, this._then);

  final _LightConnection _self;
  final $Res Function(_LightConnection) _then;

/// Create a copy of LightConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? light = freezed,Object? status = null,}) {
  return _then(_LightConnection(
freezed == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as PairedLight?,null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LinkStatus,
  ));
}

/// Create a copy of LightConnection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairedLightCopyWith<$Res>? get light {
    if (_self.light == null) {
    return null;
  }

  return $PairedLightCopyWith<$Res>(_self.light!, (value) {
    return _then(_self.copyWith(light: value));
  });
}
}

/// @nodoc
mixin _$FoundLight {

 String get id; String get name; int get rssi;
/// Create a copy of FoundLight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoundLightCopyWith<FoundLight> get copyWith => _$FoundLightCopyWithImpl<FoundLight>(this as FoundLight, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FoundLight;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoundLight&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.rssi, _this.rssi) || other.rssi == _this.rssi));
}


@override
int get hashCode {
  final _this = this as FoundLight;
  return Object.hash(runtimeType,_this.id,_this.name,_this.rssi);
}

@override
String toString() {
  final _this = this as FoundLight;
  return 'FoundLight(id: ${_this.id}, name: ${_this.name}, rssi: ${_this.rssi})';
}


}

/// @nodoc
abstract mixin class $FoundLightCopyWith<$Res>  {
  factory $FoundLightCopyWith(FoundLight value, $Res Function(FoundLight) _then) = _$FoundLightCopyWithImpl;
@useResult
$Res call({
 String id, String name, int rssi
});




}
/// @nodoc
class _$FoundLightCopyWithImpl<$Res>
    implements $FoundLightCopyWith<$Res> {
  _$FoundLightCopyWithImpl(this._self, this._then);

  final FoundLight _self;
  final $Res Function(FoundLight) _then;

/// Create a copy of FoundLight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? rssi = null,}) {
  return _then(FoundLight(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == rssi ? _self.rssi : rssi // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FoundLight].
extension FoundLightPatterns on FoundLight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoundLight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoundLight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoundLight value)  $default,){
final _that = this;
switch (_that) {
case _FoundLight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoundLight value)?  $default,){
final _that = this;
switch (_that) {
case _FoundLight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int rssi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoundLight() when $default != null:
return $default(_that.id,_that.name,_that.rssi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int rssi)  $default,) {final _that = this;
switch (_that) {
case _FoundLight():
return $default(_that.id,_that.name,_that.rssi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int rssi)?  $default,) {final _that = this;
switch (_that) {
case _FoundLight() when $default != null:
return $default(_that.id,_that.name,_that.rssi);case _:
  return null;

}
}

}

/// @nodoc


class _FoundLight implements FoundLight {
  const _FoundLight(this.id, this.name, this.rssi);
  

@override final  String id;
@override final  String name;
@override final  int rssi;

/// Create a copy of FoundLight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoundLightCopyWith<_FoundLight> get copyWith => __$FoundLightCopyWithImpl<_FoundLight>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoundLight&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.rssi, rssi) || other.rssi == rssi));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,rssi);
}

@override
String toString() {
    return 'FoundLight(id: $id, name: $name, rssi: $rssi)';
}


}

/// @nodoc
abstract mixin class _$FoundLightCopyWith<$Res> implements $FoundLightCopyWith<$Res> {
  factory _$FoundLightCopyWith(_FoundLight value, $Res Function(_FoundLight) _then) = __$FoundLightCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int rssi
});




}
/// @nodoc
class __$FoundLightCopyWithImpl<$Res>
    implements _$FoundLightCopyWith<$Res> {
  __$FoundLightCopyWithImpl(this._self, this._then);

  final _FoundLight _self;
  final $Res Function(_FoundLight) _then;

/// Create a copy of FoundLight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? rssi = null,}) {
  return _then(_FoundLight(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == rssi ? _self.rssi : rssi // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
