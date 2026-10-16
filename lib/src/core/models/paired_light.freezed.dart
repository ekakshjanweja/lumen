// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paired_light.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PairedLight {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PairedLight);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PairedLight()';
}


}

/// @nodoc
class $PairedLightCopyWith<$Res>  {
$PairedLightCopyWith(PairedLight _, $Res Function(PairedLight) __);
}


/// Adds pattern-matching-related methods to [PairedLight].
extension PairedLightPatterns on PairedLight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChannelLight value)?  channel,TResult Function( ConnectedLight value)?  connected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChannelLight() when channel != null:
return channel(_that);case ConnectedLight() when connected != null:
return connected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChannelLight value)  channel,required TResult Function( ConnectedLight value)  connected,}){
final _that = this;
switch (_that) {
case ChannelLight():
return channel(_that);case ConnectedLight():
return connected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChannelLight value)?  channel,TResult? Function( ConnectedLight value)?  connected,}){
final _that = this;
switch (_that) {
case ChannelLight() when channel != null:
return channel(_that);case ConnectedLight() when connected != null:
return connected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int channel,  int group)?  channel,TResult Function( String id,  String name)?  connected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChannelLight() when channel != null:
return channel(_that.channel,_that.group);case ConnectedLight() when connected != null:
return connected(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int channel,  int group)  channel,required TResult Function( String id,  String name)  connected,}) {final _that = this;
switch (_that) {
case ChannelLight():
return channel(_that.channel,_that.group);case ConnectedLight():
return connected(_that.id,_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int channel,  int group)?  channel,TResult? Function( String id,  String name)?  connected,}) {final _that = this;
switch (_that) {
case ChannelLight() when channel != null:
return channel(_that.channel,_that.group);case ConnectedLight() when connected != null:
return connected(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class ChannelLight implements PairedLight {
  const ChannelLight(this.channel, this.group);
  

 final  int channel;
 final  int group;

/// Create a copy of PairedLight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChannelLightCopyWith<ChannelLight> get copyWith => _$ChannelLightCopyWithImpl<ChannelLight>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChannelLight&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.group, group) || other.group == group));
}


@override
int get hashCode {
    return Object.hash(runtimeType,channel,group);
}

@override
String toString() {
    return 'PairedLight.channel(channel: $channel, group: $group)';
}


}

/// @nodoc
abstract mixin class $ChannelLightCopyWith<$Res> implements $PairedLightCopyWith<$Res> {
  factory $ChannelLightCopyWith(ChannelLight value, $Res Function(ChannelLight) _then) = _$ChannelLightCopyWithImpl;
@useResult
$Res call({
 int channel, int group
});




}
/// @nodoc
class _$ChannelLightCopyWithImpl<$Res>
    implements $ChannelLightCopyWith<$Res> {
  _$ChannelLightCopyWithImpl(this._self, this._then);

  final ChannelLight _self;
  final $Res Function(ChannelLight) _then;

/// Create a copy of PairedLight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? channel = null,Object? group = null,}) {
  return _then(ChannelLight(
null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as int,null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ConnectedLight implements PairedLight {
  const ConnectedLight(this.id, this.name);
  

 final  String id;
 final  String name;

/// Create a copy of PairedLight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectedLightCopyWith<ConnectedLight> get copyWith => _$ConnectedLightCopyWithImpl<ConnectedLight>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectedLight&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'PairedLight.connected(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $ConnectedLightCopyWith<$Res> implements $PairedLightCopyWith<$Res> {
  factory $ConnectedLightCopyWith(ConnectedLight value, $Res Function(ConnectedLight) _then) = _$ConnectedLightCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$ConnectedLightCopyWithImpl<$Res>
    implements $ConnectedLightCopyWith<$Res> {
  _$ConnectedLightCopyWithImpl(this._self, this._then);

  final ConnectedLight _self;
  final $Res Function(ConnectedLight) _then;

/// Create a copy of PairedLight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(ConnectedLight(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
