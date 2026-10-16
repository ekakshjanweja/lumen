// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'light_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LightState {

 bool get on; LightMode get mode;/// 1-24
 int get effect;/// 0-100
 int get brightness;/// 2500-9900, sent in 100 K steps
 int get kelvin;/// 0-360
 int get hue;/// 0-100
 int get saturation; int get flashmod; int get tnum; int get freq;
/// Create a copy of LightState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LightStateCopyWith<LightState> get copyWith => _$LightStateCopyWithImpl<LightState>(this as LightState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LightState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LightState&&(identical(other.on, _this.on) || other.on == _this.on)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.effect, _this.effect) || other.effect == _this.effect)&&(identical(other.brightness, _this.brightness) || other.brightness == _this.brightness)&&(identical(other.kelvin, _this.kelvin) || other.kelvin == _this.kelvin)&&(identical(other.hue, _this.hue) || other.hue == _this.hue)&&(identical(other.saturation, _this.saturation) || other.saturation == _this.saturation)&&(identical(other.flashmod, _this.flashmod) || other.flashmod == _this.flashmod)&&(identical(other.tnum, _this.tnum) || other.tnum == _this.tnum)&&(identical(other.freq, _this.freq) || other.freq == _this.freq));
}


@override
int get hashCode {
  final _this = this as LightState;
  return Object.hash(runtimeType,_this.on,_this.mode,_this.effect,_this.brightness,_this.kelvin,_this.hue,_this.saturation,_this.flashmod,_this.tnum,_this.freq);
}

@override
String toString() {
  final _this = this as LightState;
  return 'LightState(on: ${_this.on}, mode: ${_this.mode}, effect: ${_this.effect}, brightness: ${_this.brightness}, kelvin: ${_this.kelvin}, hue: ${_this.hue}, saturation: ${_this.saturation}, flashmod: ${_this.flashmod}, tnum: ${_this.tnum}, freq: ${_this.freq})';
}


}

/// @nodoc
abstract mixin class $LightStateCopyWith<$Res>  {
  factory $LightStateCopyWith(LightState value, $Res Function(LightState) _then) = _$LightStateCopyWithImpl;
@useResult
$Res call({
 bool on, LightMode mode, int effect, int brightness, int kelvin, int hue, int saturation, int flashmod, int tnum, int freq
});




}
/// @nodoc
class _$LightStateCopyWithImpl<$Res>
    implements $LightStateCopyWith<$Res> {
  _$LightStateCopyWithImpl(this._self, this._then);

  final LightState _self;
  final $Res Function(LightState) _then;

/// Create a copy of LightState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? on = null,Object? mode = null,Object? effect = null,Object? brightness = null,Object? kelvin = null,Object? hue = null,Object? saturation = null,Object? flashmod = null,Object? tnum = null,Object? freq = null,}) {
  return _then(LightState(
on: null == on ? _self.on : on // ignore: cast_nullable_to_non_nullable
as bool,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as LightMode,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as int,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as int,kelvin: null == kelvin ? _self.kelvin : kelvin // ignore: cast_nullable_to_non_nullable
as int,hue: null == hue ? _self.hue : hue // ignore: cast_nullable_to_non_nullable
as int,saturation: null == saturation ? _self.saturation : saturation // ignore: cast_nullable_to_non_nullable
as int,flashmod: null == flashmod ? _self.flashmod : flashmod // ignore: cast_nullable_to_non_nullable
as int,tnum: null == tnum ? _self.tnum : tnum // ignore: cast_nullable_to_non_nullable
as int,freq: null == freq ? _self.freq : freq // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LightState].
extension LightStatePatterns on LightState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LightState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LightState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LightState value)  $default,){
final _that = this;
switch (_that) {
case _LightState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LightState value)?  $default,){
final _that = this;
switch (_that) {
case _LightState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool on,  LightMode mode,  int effect,  int brightness,  int kelvin,  int hue,  int saturation,  int flashmod,  int tnum,  int freq)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LightState() when $default != null:
return $default(_that.on,_that.mode,_that.effect,_that.brightness,_that.kelvin,_that.hue,_that.saturation,_that.flashmod,_that.tnum,_that.freq);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool on,  LightMode mode,  int effect,  int brightness,  int kelvin,  int hue,  int saturation,  int flashmod,  int tnum,  int freq)  $default,) {final _that = this;
switch (_that) {
case _LightState():
return $default(_that.on,_that.mode,_that.effect,_that.brightness,_that.kelvin,_that.hue,_that.saturation,_that.flashmod,_that.tnum,_that.freq);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool on,  LightMode mode,  int effect,  int brightness,  int kelvin,  int hue,  int saturation,  int flashmod,  int tnum,  int freq)?  $default,) {final _that = this;
switch (_that) {
case _LightState() when $default != null:
return $default(_that.on,_that.mode,_that.effect,_that.brightness,_that.kelvin,_that.hue,_that.saturation,_that.flashmod,_that.tnum,_that.freq);case _:
  return null;

}
}

}

/// @nodoc


class _LightState implements LightState {
  const _LightState({this.on = true, this.mode = LightMode.white, this.effect = 1, this.brightness = 50, this.kelvin = 5600, this.hue = 0, this.saturation = 100, this.flashmod = 0, this.tnum = 100, this.freq = 0});
  

@override@JsonKey() final  bool on;
@override@JsonKey() final  LightMode mode;
/// 1-24
@override@JsonKey() final  int effect;
/// 0-100
@override@JsonKey() final  int brightness;
/// 2500-9900, sent in 100 K steps
@override@JsonKey() final  int kelvin;
/// 0-360
@override@JsonKey() final  int hue;
/// 0-100
@override@JsonKey() final  int saturation;
@override@JsonKey() final  int flashmod;
@override@JsonKey() final  int tnum;
@override@JsonKey() final  int freq;

/// Create a copy of LightState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LightStateCopyWith<_LightState> get copyWith => __$LightStateCopyWithImpl<_LightState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LightState&&(identical(other.on, on) || other.on == on)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.effect, effect) || other.effect == effect)&&(identical(other.brightness, brightness) || other.brightness == brightness)&&(identical(other.kelvin, kelvin) || other.kelvin == kelvin)&&(identical(other.hue, hue) || other.hue == hue)&&(identical(other.saturation, saturation) || other.saturation == saturation)&&(identical(other.flashmod, flashmod) || other.flashmod == flashmod)&&(identical(other.tnum, tnum) || other.tnum == tnum)&&(identical(other.freq, freq) || other.freq == freq));
}


@override
int get hashCode {
    return Object.hash(runtimeType,on,mode,effect,brightness,kelvin,hue,saturation,flashmod,tnum,freq);
}

@override
String toString() {
    return 'LightState(on: $on, mode: $mode, effect: $effect, brightness: $brightness, kelvin: $kelvin, hue: $hue, saturation: $saturation, flashmod: $flashmod, tnum: $tnum, freq: $freq)';
}


}

/// @nodoc
abstract mixin class _$LightStateCopyWith<$Res> implements $LightStateCopyWith<$Res> {
  factory _$LightStateCopyWith(_LightState value, $Res Function(_LightState) _then) = __$LightStateCopyWithImpl;
@override @useResult
$Res call({
 bool on, LightMode mode, int effect, int brightness, int kelvin, int hue, int saturation, int flashmod, int tnum, int freq
});




}
/// @nodoc
class __$LightStateCopyWithImpl<$Res>
    implements _$LightStateCopyWith<$Res> {
  __$LightStateCopyWithImpl(this._self, this._then);

  final _LightState _self;
  final $Res Function(_LightState) _then;

/// Create a copy of LightState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? on = null,Object? mode = null,Object? effect = null,Object? brightness = null,Object? kelvin = null,Object? hue = null,Object? saturation = null,Object? flashmod = null,Object? tnum = null,Object? freq = null,}) {
  return _then(_LightState(
on: null == on ? _self.on : on // ignore: cast_nullable_to_non_nullable
as bool,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as LightMode,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as int,brightness: null == brightness ? _self.brightness : brightness // ignore: cast_nullable_to_non_nullable
as int,kelvin: null == kelvin ? _self.kelvin : kelvin // ignore: cast_nullable_to_non_nullable
as int,hue: null == hue ? _self.hue : hue // ignore: cast_nullable_to_non_nullable
as int,saturation: null == saturation ? _self.saturation : saturation // ignore: cast_nullable_to_non_nullable
as int,flashmod: null == flashmod ? _self.flashmod : flashmod // ignore: cast_nullable_to_non_nullable
as int,tnum: null == tnum ? _self.tnum : tnum // ignore: cast_nullable_to_non_nullable
as int,freq: null == freq ? _self.freq : freq // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
