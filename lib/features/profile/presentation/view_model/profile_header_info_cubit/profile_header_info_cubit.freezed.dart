// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_header_info_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileHeaderInfoState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileHeaderInfoState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileHeaderInfoState()';
}


}

/// @nodoc
class $ProfileHeaderInfoStateCopyWith<$Res>  {
$ProfileHeaderInfoStateCopyWith(ProfileHeaderInfoState _, $Res Function(ProfileHeaderInfoState) __);
}


/// Adds pattern-matching-related methods to [ProfileHeaderInfoState].
extension ProfileHeaderInfoStatePatterns on ProfileHeaderInfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _GetProfileHeaderInfoLoading value)?  getProfileHeaderInfoLoading,TResult Function( _GetProfileHeaderInfoFailure value)?  getProfileHeaderInfoFailure,TResult Function( _GetProfileHeaderInfoSuccessSuccess value)?  getProfileHeaderInfoSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GetProfileHeaderInfoLoading() when getProfileHeaderInfoLoading != null:
return getProfileHeaderInfoLoading(_that);case _GetProfileHeaderInfoFailure() when getProfileHeaderInfoFailure != null:
return getProfileHeaderInfoFailure(_that);case _GetProfileHeaderInfoSuccessSuccess() when getProfileHeaderInfoSuccess != null:
return getProfileHeaderInfoSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _GetProfileHeaderInfoLoading value)  getProfileHeaderInfoLoading,required TResult Function( _GetProfileHeaderInfoFailure value)  getProfileHeaderInfoFailure,required TResult Function( _GetProfileHeaderInfoSuccessSuccess value)  getProfileHeaderInfoSuccess,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _GetProfileHeaderInfoLoading():
return getProfileHeaderInfoLoading(_that);case _GetProfileHeaderInfoFailure():
return getProfileHeaderInfoFailure(_that);case _GetProfileHeaderInfoSuccessSuccess():
return getProfileHeaderInfoSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _GetProfileHeaderInfoLoading value)?  getProfileHeaderInfoLoading,TResult? Function( _GetProfileHeaderInfoFailure value)?  getProfileHeaderInfoFailure,TResult? Function( _GetProfileHeaderInfoSuccessSuccess value)?  getProfileHeaderInfoSuccess,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GetProfileHeaderInfoLoading() when getProfileHeaderInfoLoading != null:
return getProfileHeaderInfoLoading(_that);case _GetProfileHeaderInfoFailure() when getProfileHeaderInfoFailure != null:
return getProfileHeaderInfoFailure(_that);case _GetProfileHeaderInfoSuccessSuccess() when getProfileHeaderInfoSuccess != null:
return getProfileHeaderInfoSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  getProfileHeaderInfoLoading,TResult Function( String errorMessage)?  getProfileHeaderInfoFailure,TResult Function( String name,  String email)?  getProfileHeaderInfoSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GetProfileHeaderInfoLoading() when getProfileHeaderInfoLoading != null:
return getProfileHeaderInfoLoading();case _GetProfileHeaderInfoFailure() when getProfileHeaderInfoFailure != null:
return getProfileHeaderInfoFailure(_that.errorMessage);case _GetProfileHeaderInfoSuccessSuccess() when getProfileHeaderInfoSuccess != null:
return getProfileHeaderInfoSuccess(_that.name,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  getProfileHeaderInfoLoading,required TResult Function( String errorMessage)  getProfileHeaderInfoFailure,required TResult Function( String name,  String email)  getProfileHeaderInfoSuccess,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _GetProfileHeaderInfoLoading():
return getProfileHeaderInfoLoading();case _GetProfileHeaderInfoFailure():
return getProfileHeaderInfoFailure(_that.errorMessage);case _GetProfileHeaderInfoSuccessSuccess():
return getProfileHeaderInfoSuccess(_that.name,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  getProfileHeaderInfoLoading,TResult? Function( String errorMessage)?  getProfileHeaderInfoFailure,TResult? Function( String name,  String email)?  getProfileHeaderInfoSuccess,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GetProfileHeaderInfoLoading() when getProfileHeaderInfoLoading != null:
return getProfileHeaderInfoLoading();case _GetProfileHeaderInfoFailure() when getProfileHeaderInfoFailure != null:
return getProfileHeaderInfoFailure(_that.errorMessage);case _GetProfileHeaderInfoSuccessSuccess() when getProfileHeaderInfoSuccess != null:
return getProfileHeaderInfoSuccess(_that.name,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProfileHeaderInfoState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileHeaderInfoState.initial()';
}


}




/// @nodoc


class _GetProfileHeaderInfoLoading implements ProfileHeaderInfoState {
  const _GetProfileHeaderInfoLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetProfileHeaderInfoLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileHeaderInfoState.getProfileHeaderInfoLoading()';
}


}




/// @nodoc


class _GetProfileHeaderInfoFailure implements ProfileHeaderInfoState {
  const _GetProfileHeaderInfoFailure({required this.errorMessage});
  

 final  String errorMessage;

/// Create a copy of ProfileHeaderInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetProfileHeaderInfoFailureCopyWith<_GetProfileHeaderInfoFailure> get copyWith => __$GetProfileHeaderInfoFailureCopyWithImpl<_GetProfileHeaderInfoFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetProfileHeaderInfoFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'ProfileHeaderInfoState.getProfileHeaderInfoFailure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GetProfileHeaderInfoFailureCopyWith<$Res> implements $ProfileHeaderInfoStateCopyWith<$Res> {
  factory _$GetProfileHeaderInfoFailureCopyWith(_GetProfileHeaderInfoFailure value, $Res Function(_GetProfileHeaderInfoFailure) _then) = __$GetProfileHeaderInfoFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class __$GetProfileHeaderInfoFailureCopyWithImpl<$Res>
    implements _$GetProfileHeaderInfoFailureCopyWith<$Res> {
  __$GetProfileHeaderInfoFailureCopyWithImpl(this._self, this._then);

  final _GetProfileHeaderInfoFailure _self;
  final $Res Function(_GetProfileHeaderInfoFailure) _then;

/// Create a copy of ProfileHeaderInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_GetProfileHeaderInfoFailure(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GetProfileHeaderInfoSuccessSuccess implements ProfileHeaderInfoState {
  const _GetProfileHeaderInfoSuccessSuccess({required this.name, required this.email});
  

 final  String name;
 final  String email;

/// Create a copy of ProfileHeaderInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetProfileHeaderInfoSuccessSuccessCopyWith<_GetProfileHeaderInfoSuccessSuccess> get copyWith => __$GetProfileHeaderInfoSuccessSuccessCopyWithImpl<_GetProfileHeaderInfoSuccessSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetProfileHeaderInfoSuccessSuccess&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,name,email);

@override
String toString() {
  return 'ProfileHeaderInfoState.getProfileHeaderInfoSuccess(name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class _$GetProfileHeaderInfoSuccessSuccessCopyWith<$Res> implements $ProfileHeaderInfoStateCopyWith<$Res> {
  factory _$GetProfileHeaderInfoSuccessSuccessCopyWith(_GetProfileHeaderInfoSuccessSuccess value, $Res Function(_GetProfileHeaderInfoSuccessSuccess) _then) = __$GetProfileHeaderInfoSuccessSuccessCopyWithImpl;
@useResult
$Res call({
 String name, String email
});




}
/// @nodoc
class __$GetProfileHeaderInfoSuccessSuccessCopyWithImpl<$Res>
    implements _$GetProfileHeaderInfoSuccessSuccessCopyWith<$Res> {
  __$GetProfileHeaderInfoSuccessSuccessCopyWithImpl(this._self, this._then);

  final _GetProfileHeaderInfoSuccessSuccess _self;
  final $Res Function(_GetProfileHeaderInfoSuccessSuccess) _then;

/// Create a copy of ProfileHeaderInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,}) {
  return _then(_GetProfileHeaderInfoSuccessSuccess(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
