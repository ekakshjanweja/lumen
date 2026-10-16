// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ColorPreset {

 String get id; String get name;/// 0-359
 int get hue;/// 0-100
 int get saturation;/// Shipped with the app, so it cannot be deleted.
 bool get builtIn;
/// Create a copy of ColorPreset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColorPresetCopyWith<ColorPreset> get copyWith => _$ColorPresetCopyWithImpl<ColorPreset>(this as ColorPreset, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ColorPreset;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColorPreset&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.hue, _this.hue) || other.hue == _this.hue)&&(identical(other.saturation, _this.saturation) || other.saturation == _this.saturation)&&(identical(other.builtIn, _this.builtIn) || other.builtIn == _this.builtIn));
}


@override
int get hashCode {
  final _this = this as ColorPreset;
  return Object.hash(runtimeType,_this.id,_this.name,_this.hue,_this.saturation,_this.builtIn);
}

@override
String toString() {
  final _this = this as ColorPreset;
  return 'ColorPreset(id: ${_this.id}, name: ${_this.name}, hue: ${_this.hue}, saturation: ${_this.saturation}, builtIn: ${_this.builtIn})';
}


}

/// @nodoc
abstract mixin class $ColorPresetCopyWith<$Res>  {
  factory $ColorPresetCopyWith(ColorPreset value, $Res Function(ColorPreset) _then) = _$ColorPresetCopyWithImpl;
@useResult
$Res call({
 String id, String name, int hue, int saturation, bool builtIn
});




}
/// @nodoc
class _$ColorPresetCopyWithImpl<$Res>
    implements $ColorPresetCopyWith<$Res> {
  _$ColorPresetCopyWithImpl(this._self, this._then);

  final ColorPreset _self;
  final $Res Function(ColorPreset) _then;

/// Create a copy of ColorPreset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? hue = null,Object? saturation = null,Object? builtIn = null,}) {
  return _then(ColorPreset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hue: null == hue ? _self.hue : hue // ignore: cast_nullable_to_non_nullable
as int,saturation: null == saturation ? _self.saturation : saturation // ignore: cast_nullable_to_non_nullable
as int,builtIn: null == builtIn ? _self.builtIn : builtIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ColorPreset].
extension ColorPresetPatterns on ColorPreset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColorPreset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColorPreset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColorPreset value)  $default,){
final _that = this;
switch (_that) {
case _ColorPreset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColorPreset value)?  $default,){
final _that = this;
switch (_that) {
case _ColorPreset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int hue,  int saturation,  bool builtIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColorPreset() when $default != null:
return $default(_that.id,_that.name,_that.hue,_that.saturation,_that.builtIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int hue,  int saturation,  bool builtIn)  $default,) {final _that = this;
switch (_that) {
case _ColorPreset():
return $default(_that.id,_that.name,_that.hue,_that.saturation,_that.builtIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int hue,  int saturation,  bool builtIn)?  $default,) {final _that = this;
switch (_that) {
case _ColorPreset() when $default != null:
return $default(_that.id,_that.name,_that.hue,_that.saturation,_that.builtIn);case _:
  return null;

}
}

}

/// @nodoc


class _ColorPreset implements ColorPreset {
  const _ColorPreset({required this.id, required this.name, required this.hue, required this.saturation, this.builtIn = false});
  

@override final  String id;
@override final  String name;
/// 0-359
@override final  int hue;
/// 0-100
@override final  int saturation;
/// Shipped with the app, so it cannot be deleted.
@override@JsonKey() final  bool builtIn;

/// Create a copy of ColorPreset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColorPresetCopyWith<_ColorPreset> get copyWith => __$ColorPresetCopyWithImpl<_ColorPreset>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColorPreset&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.hue, hue) || other.hue == hue)&&(identical(other.saturation, saturation) || other.saturation == saturation)&&(identical(other.builtIn, builtIn) || other.builtIn == builtIn));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,hue,saturation,builtIn);
}

@override
String toString() {
    return 'ColorPreset(id: $id, name: $name, hue: $hue, saturation: $saturation, builtIn: $builtIn)';
}


}

/// @nodoc
abstract mixin class _$ColorPresetCopyWith<$Res> implements $ColorPresetCopyWith<$Res> {
  factory _$ColorPresetCopyWith(_ColorPreset value, $Res Function(_ColorPreset) _then) = __$ColorPresetCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int hue, int saturation, bool builtIn
});




}
/// @nodoc
class __$ColorPresetCopyWithImpl<$Res>
    implements _$ColorPresetCopyWith<$Res> {
  __$ColorPresetCopyWithImpl(this._self, this._then);

  final _ColorPreset _self;
  final $Res Function(_ColorPreset) _then;

/// Create a copy of ColorPreset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? hue = null,Object? saturation = null,Object? builtIn = null,}) {
  return _then(_ColorPreset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hue: null == hue ? _self.hue : hue // ignore: cast_nullable_to_non_nullable
as int,saturation: null == saturation ? _self.saturation : saturation // ignore: cast_nullable_to_non_nullable
as int,builtIn: null == builtIn ? _self.builtIn : builtIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
