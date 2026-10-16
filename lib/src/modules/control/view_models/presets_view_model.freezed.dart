// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presets_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PresetsState {

 List<ColorPreset> get saved; List<ColorPreset> get builtIns;
/// Create a copy of PresetsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresetsStateCopyWith<PresetsState> get copyWith => _$PresetsStateCopyWithImpl<PresetsState>(this as PresetsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PresetsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresetsState&&const DeepCollectionEquality().equals(other.saved, _this.saved)&&const DeepCollectionEquality().equals(other.builtIns, _this.builtIns));
}


@override
int get hashCode {
  final _this = this as PresetsState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.saved),const DeepCollectionEquality().hash(_this.builtIns));
}

@override
String toString() {
  final _this = this as PresetsState;
  return 'PresetsState(saved: ${_this.saved}, builtIns: ${_this.builtIns})';
}


}

/// @nodoc
abstract mixin class $PresetsStateCopyWith<$Res>  {
  factory $PresetsStateCopyWith(PresetsState value, $Res Function(PresetsState) _then) = _$PresetsStateCopyWithImpl;
@useResult
$Res call({
 List<ColorPreset> saved, List<ColorPreset> builtIns
});




}
/// @nodoc
class _$PresetsStateCopyWithImpl<$Res>
    implements $PresetsStateCopyWith<$Res> {
  _$PresetsStateCopyWithImpl(this._self, this._then);

  final PresetsState _self;
  final $Res Function(PresetsState) _then;

/// Create a copy of PresetsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? saved = null,Object? builtIns = null,}) {
  return _then(PresetsState(
saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as List<ColorPreset>,builtIns: null == builtIns ? _self.builtIns : builtIns // ignore: cast_nullable_to_non_nullable
as List<ColorPreset>,
  ));
}

}


/// Adds pattern-matching-related methods to [PresetsState].
extension PresetsStatePatterns on PresetsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PresetsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PresetsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PresetsState value)  $default,){
final _that = this;
switch (_that) {
case _PresetsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PresetsState value)?  $default,){
final _that = this;
switch (_that) {
case _PresetsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ColorPreset> saved,  List<ColorPreset> builtIns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PresetsState() when $default != null:
return $default(_that.saved,_that.builtIns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ColorPreset> saved,  List<ColorPreset> builtIns)  $default,) {final _that = this;
switch (_that) {
case _PresetsState():
return $default(_that.saved,_that.builtIns);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ColorPreset> saved,  List<ColorPreset> builtIns)?  $default,) {final _that = this;
switch (_that) {
case _PresetsState() when $default != null:
return $default(_that.saved,_that.builtIns);case _:
  return null;

}
}

}

/// @nodoc


class _PresetsState extends PresetsState {
  const _PresetsState({ List<ColorPreset> saved = const [],  List<ColorPreset> builtIns = builtInPresets}): _saved = saved,_builtIns = builtIns,super._();
  

 final  List<ColorPreset> _saved;
@override@JsonKey() List<ColorPreset> get saved {
  if (_saved is EqualUnmodifiableListView) return _saved;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_saved);
}

 final  List<ColorPreset> _builtIns;
@override@JsonKey() List<ColorPreset> get builtIns {
  if (_builtIns is EqualUnmodifiableListView) return _builtIns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_builtIns);
}


/// Create a copy of PresetsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PresetsStateCopyWith<_PresetsState> get copyWith => __$PresetsStateCopyWithImpl<_PresetsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PresetsState&&const DeepCollectionEquality().equals(other.saved, _saved)&&const DeepCollectionEquality().equals(other.builtIns, _builtIns));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_saved),const DeepCollectionEquality().hash(_builtIns));
}

@override
String toString() {
    return 'PresetsState(saved: $saved, builtIns: $builtIns)';
}


}

/// @nodoc
abstract mixin class _$PresetsStateCopyWith<$Res> implements $PresetsStateCopyWith<$Res> {
  factory _$PresetsStateCopyWith(_PresetsState value, $Res Function(_PresetsState) _then) = __$PresetsStateCopyWithImpl;
@override @useResult
$Res call({
 List<ColorPreset> saved, List<ColorPreset> builtIns
});




}
/// @nodoc
class __$PresetsStateCopyWithImpl<$Res>
    implements _$PresetsStateCopyWith<$Res> {
  __$PresetsStateCopyWithImpl(this._self, this._then);

  final _PresetsState _self;
  final $Res Function(_PresetsState) _then;

/// Create a copy of PresetsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? saved = null,Object? builtIns = null,}) {
  return _then(_PresetsState(
saved: null == saved ? _self._saved : saved // ignore: cast_nullable_to_non_nullable
as List<ColorPreset>,builtIns: null == builtIns ? _self._builtIns : builtIns // ignore: cast_nullable_to_non_nullable
as List<ColorPreset>,
  ));
}


}

// dart format on
