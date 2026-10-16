// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'effect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Effect {

 int get id; String get name; String get group;
/// Create a copy of Effect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EffectCopyWith<Effect> get copyWith => _$EffectCopyWithImpl<Effect>(this as Effect, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Effect;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Effect&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.group, _this.group) || other.group == _this.group));
}


@override
int get hashCode {
  final _this = this as Effect;
  return Object.hash(runtimeType,_this.id,_this.name,_this.group);
}

@override
String toString() {
  final _this = this as Effect;
  return 'Effect(id: ${_this.id}, name: ${_this.name}, group: ${_this.group})';
}


}

/// @nodoc
abstract mixin class $EffectCopyWith<$Res>  {
  factory $EffectCopyWith(Effect value, $Res Function(Effect) _then) = _$EffectCopyWithImpl;
@useResult
$Res call({
 int id, String name, String group
});




}
/// @nodoc
class _$EffectCopyWithImpl<$Res>
    implements $EffectCopyWith<$Res> {
  _$EffectCopyWithImpl(this._self, this._then);

  final Effect _self;
  final $Res Function(Effect) _then;

/// Create a copy of Effect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? group = null,}) {
  return _then(Effect(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Effect].
extension EffectPatterns on Effect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Effect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Effect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Effect value)  $default,){
final _that = this;
switch (_that) {
case _Effect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Effect value)?  $default,){
final _that = this;
switch (_that) {
case _Effect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String group)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Effect() when $default != null:
return $default(_that.id,_that.name,_that.group);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String group)  $default,) {final _that = this;
switch (_that) {
case _Effect():
return $default(_that.id,_that.name,_that.group);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String group)?  $default,) {final _that = this;
switch (_that) {
case _Effect() when $default != null:
return $default(_that.id,_that.name,_that.group);case _:
  return null;

}
}

}

/// @nodoc


class _Effect implements Effect {
  const _Effect(this.id, this.name, this.group);
  

@override final  int id;
@override final  String name;
@override final  String group;

/// Create a copy of Effect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EffectCopyWith<_Effect> get copyWith => __$EffectCopyWithImpl<_Effect>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Effect&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.group, group) || other.group == group));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,group);
}

@override
String toString() {
    return 'Effect(id: $id, name: $name, group: $group)';
}


}

/// @nodoc
abstract mixin class _$EffectCopyWith<$Res> implements $EffectCopyWith<$Res> {
  factory _$EffectCopyWith(_Effect value, $Res Function(_Effect) _then) = __$EffectCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String group
});




}
/// @nodoc
class __$EffectCopyWithImpl<$Res>
    implements _$EffectCopyWith<$Res> {
  __$EffectCopyWithImpl(this._self, this._then);

  final _Effect _self;
  final $Res Function(_Effect) _then;

/// Create a copy of Effect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? group = null,}) {
  return _then(_Effect(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
