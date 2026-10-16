// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {

 SearchStep get step;/// 0-1 through the channel sweep.
 double get progress;/// Which of [candidateCount] possible matches is being flashed.
 int get candidate; int get candidateCount;/// Lights that do show up in a Bluetooth scan.
 List<FoundLight> get nearby; String? get connectingId;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SearchState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.candidate, _this.candidate) || other.candidate == _this.candidate)&&(identical(other.candidateCount, _this.candidateCount) || other.candidateCount == _this.candidateCount)&&const DeepCollectionEquality().equals(other.nearby, _this.nearby)&&(identical(other.connectingId, _this.connectingId) || other.connectingId == _this.connectingId));
}


@override
int get hashCode {
  final _this = this as SearchState;
  return Object.hash(runtimeType,_this.step,_this.progress,_this.candidate,_this.candidateCount,const DeepCollectionEquality().hash(_this.nearby),_this.connectingId);
}

@override
String toString() {
  final _this = this as SearchState;
  return 'SearchState(step: ${_this.step}, progress: ${_this.progress}, candidate: ${_this.candidate}, candidateCount: ${_this.candidateCount}, nearby: ${_this.nearby}, connectingId: ${_this.connectingId})';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 SearchStep step, double progress, int candidate, int candidateCount, List<FoundLight> nearby, String? connectingId
});




}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? progress = null,Object? candidate = null,Object? candidateCount = null,Object? nearby = null,Object? connectingId = freezed,}) {
  return _then(SearchState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SearchStep,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,candidate: null == candidate ? _self.candidate : candidate // ignore: cast_nullable_to_non_nullable
as int,candidateCount: null == candidateCount ? _self.candidateCount : candidateCount // ignore: cast_nullable_to_non_nullable
as int,nearby: null == nearby ? _self.nearby : nearby // ignore: cast_nullable_to_non_nullable
as List<FoundLight>,connectingId: freezed == connectingId ? _self.connectingId : connectingId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchState value)  $default,){
final _that = this;
switch (_that) {
case _SearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchState value)?  $default,){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchStep step,  double progress,  int candidate,  int candidateCount,  List<FoundLight> nearby,  String? connectingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.step,_that.progress,_that.candidate,_that.candidateCount,_that.nearby,_that.connectingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchStep step,  double progress,  int candidate,  int candidateCount,  List<FoundLight> nearby,  String? connectingId)  $default,) {final _that = this;
switch (_that) {
case _SearchState():
return $default(_that.step,_that.progress,_that.candidate,_that.candidateCount,_that.nearby,_that.connectingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchStep step,  double progress,  int candidate,  int candidateCount,  List<FoundLight> nearby,  String? connectingId)?  $default,) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.step,_that.progress,_that.candidate,_that.candidateCount,_that.nearby,_that.connectingId);case _:
  return null;

}
}

}

/// @nodoc


class _SearchState implements SearchState {
  const _SearchState({this.step = SearchStep.intro, this.progress = 0, this.candidate = 0, this.candidateCount = 0,  List<FoundLight> nearby = const [], this.connectingId}): _nearby = nearby;
  

@override@JsonKey() final  SearchStep step;
/// 0-1 through the channel sweep.
@override@JsonKey() final  double progress;
/// Which of [candidateCount] possible matches is being flashed.
@override@JsonKey() final  int candidate;
@override@JsonKey() final  int candidateCount;
/// Lights that do show up in a Bluetooth scan.
 final  List<FoundLight> _nearby;
/// Lights that do show up in a Bluetooth scan.
@override@JsonKey() List<FoundLight> get nearby {
  if (_nearby is EqualUnmodifiableListView) return _nearby;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearby);
}

@override final  String? connectingId;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateCopyWith<_SearchState> get copyWith => __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchState&&(identical(other.step, step) || other.step == step)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.candidate, candidate) || other.candidate == candidate)&&(identical(other.candidateCount, candidateCount) || other.candidateCount == candidateCount)&&const DeepCollectionEquality().equals(other.nearby, _nearby)&&(identical(other.connectingId, connectingId) || other.connectingId == connectingId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,progress,candidate,candidateCount,const DeepCollectionEquality().hash(_nearby),connectingId);
}

@override
String toString() {
    return 'SearchState(step: $step, progress: $progress, candidate: $candidate, candidateCount: $candidateCount, nearby: $nearby, connectingId: $connectingId)';
}


}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(_SearchState value, $Res Function(_SearchState) _then) = __$SearchStateCopyWithImpl;
@override @useResult
$Res call({
 SearchStep step, double progress, int candidate, int candidateCount, List<FoundLight> nearby, String? connectingId
});




}
/// @nodoc
class __$SearchStateCopyWithImpl<$Res>
    implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? progress = null,Object? candidate = null,Object? candidateCount = null,Object? nearby = null,Object? connectingId = freezed,}) {
  return _then(_SearchState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SearchStep,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,candidate: null == candidate ? _self.candidate : candidate // ignore: cast_nullable_to_non_nullable
as int,candidateCount: null == candidateCount ? _self.candidateCount : candidateCount // ignore: cast_nullable_to_non_nullable
as int,nearby: null == nearby ? _self._nearby : nearby // ignore: cast_nullable_to_non_nullable
as List<FoundLight>,connectingId: freezed == connectingId ? _self.connectingId : connectingId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
