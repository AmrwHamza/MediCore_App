// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'departments_view_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DepartmentsViewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartmentsViewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DepartmentsViewState()';
}


}

/// @nodoc
class $DepartmentsViewStateCopyWith<$Res>  {
$DepartmentsViewStateCopyWith(DepartmentsViewState _, $Res Function(DepartmentsViewState) __);
}


/// Adds pattern-matching-related methods to [DepartmentsViewState].
extension DepartmentsViewStatePatterns on DepartmentsViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _GetDepartmentsLoading value)?  getDepartmentsLoading,TResult Function( _SearchDepartmentsLoading value)?  searchDepartmentsLoading,TResult Function( _GetDepartmentsFailure value)?  getDepartmentsFailure,TResult Function( _SearchDepartmentsFailure value)?  searchDepartmentsFailure,TResult Function( _GetDepartmentsSuccess value)?  getDepartmentsSuccess,TResult Function( _SearchDepartmentsSuccess value)?  searchDepartmentsSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GetDepartmentsLoading() when getDepartmentsLoading != null:
return getDepartmentsLoading(_that);case _SearchDepartmentsLoading() when searchDepartmentsLoading != null:
return searchDepartmentsLoading(_that);case _GetDepartmentsFailure() when getDepartmentsFailure != null:
return getDepartmentsFailure(_that);case _SearchDepartmentsFailure() when searchDepartmentsFailure != null:
return searchDepartmentsFailure(_that);case _GetDepartmentsSuccess() when getDepartmentsSuccess != null:
return getDepartmentsSuccess(_that);case _SearchDepartmentsSuccess() when searchDepartmentsSuccess != null:
return searchDepartmentsSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _GetDepartmentsLoading value)  getDepartmentsLoading,required TResult Function( _SearchDepartmentsLoading value)  searchDepartmentsLoading,required TResult Function( _GetDepartmentsFailure value)  getDepartmentsFailure,required TResult Function( _SearchDepartmentsFailure value)  searchDepartmentsFailure,required TResult Function( _GetDepartmentsSuccess value)  getDepartmentsSuccess,required TResult Function( _SearchDepartmentsSuccess value)  searchDepartmentsSuccess,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _GetDepartmentsLoading():
return getDepartmentsLoading(_that);case _SearchDepartmentsLoading():
return searchDepartmentsLoading(_that);case _GetDepartmentsFailure():
return getDepartmentsFailure(_that);case _SearchDepartmentsFailure():
return searchDepartmentsFailure(_that);case _GetDepartmentsSuccess():
return getDepartmentsSuccess(_that);case _SearchDepartmentsSuccess():
return searchDepartmentsSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _GetDepartmentsLoading value)?  getDepartmentsLoading,TResult? Function( _SearchDepartmentsLoading value)?  searchDepartmentsLoading,TResult? Function( _GetDepartmentsFailure value)?  getDepartmentsFailure,TResult? Function( _SearchDepartmentsFailure value)?  searchDepartmentsFailure,TResult? Function( _GetDepartmentsSuccess value)?  getDepartmentsSuccess,TResult? Function( _SearchDepartmentsSuccess value)?  searchDepartmentsSuccess,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GetDepartmentsLoading() when getDepartmentsLoading != null:
return getDepartmentsLoading(_that);case _SearchDepartmentsLoading() when searchDepartmentsLoading != null:
return searchDepartmentsLoading(_that);case _GetDepartmentsFailure() when getDepartmentsFailure != null:
return getDepartmentsFailure(_that);case _SearchDepartmentsFailure() when searchDepartmentsFailure != null:
return searchDepartmentsFailure(_that);case _GetDepartmentsSuccess() when getDepartmentsSuccess != null:
return getDepartmentsSuccess(_that);case _SearchDepartmentsSuccess() when searchDepartmentsSuccess != null:
return searchDepartmentsSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  getDepartmentsLoading,TResult Function()?  searchDepartmentsLoading,TResult Function( String errorMessage)?  getDepartmentsFailure,TResult Function( String errorMessage)?  searchDepartmentsFailure,TResult Function( List<DepartmentEntity> departments)?  getDepartmentsSuccess,TResult Function( List<DepartmentEntity> departments)?  searchDepartmentsSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GetDepartmentsLoading() when getDepartmentsLoading != null:
return getDepartmentsLoading();case _SearchDepartmentsLoading() when searchDepartmentsLoading != null:
return searchDepartmentsLoading();case _GetDepartmentsFailure() when getDepartmentsFailure != null:
return getDepartmentsFailure(_that.errorMessage);case _SearchDepartmentsFailure() when searchDepartmentsFailure != null:
return searchDepartmentsFailure(_that.errorMessage);case _GetDepartmentsSuccess() when getDepartmentsSuccess != null:
return getDepartmentsSuccess(_that.departments);case _SearchDepartmentsSuccess() when searchDepartmentsSuccess != null:
return searchDepartmentsSuccess(_that.departments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  getDepartmentsLoading,required TResult Function()  searchDepartmentsLoading,required TResult Function( String errorMessage)  getDepartmentsFailure,required TResult Function( String errorMessage)  searchDepartmentsFailure,required TResult Function( List<DepartmentEntity> departments)  getDepartmentsSuccess,required TResult Function( List<DepartmentEntity> departments)  searchDepartmentsSuccess,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _GetDepartmentsLoading():
return getDepartmentsLoading();case _SearchDepartmentsLoading():
return searchDepartmentsLoading();case _GetDepartmentsFailure():
return getDepartmentsFailure(_that.errorMessage);case _SearchDepartmentsFailure():
return searchDepartmentsFailure(_that.errorMessage);case _GetDepartmentsSuccess():
return getDepartmentsSuccess(_that.departments);case _SearchDepartmentsSuccess():
return searchDepartmentsSuccess(_that.departments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  getDepartmentsLoading,TResult? Function()?  searchDepartmentsLoading,TResult? Function( String errorMessage)?  getDepartmentsFailure,TResult? Function( String errorMessage)?  searchDepartmentsFailure,TResult? Function( List<DepartmentEntity> departments)?  getDepartmentsSuccess,TResult? Function( List<DepartmentEntity> departments)?  searchDepartmentsSuccess,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GetDepartmentsLoading() when getDepartmentsLoading != null:
return getDepartmentsLoading();case _SearchDepartmentsLoading() when searchDepartmentsLoading != null:
return searchDepartmentsLoading();case _GetDepartmentsFailure() when getDepartmentsFailure != null:
return getDepartmentsFailure(_that.errorMessage);case _SearchDepartmentsFailure() when searchDepartmentsFailure != null:
return searchDepartmentsFailure(_that.errorMessage);case _GetDepartmentsSuccess() when getDepartmentsSuccess != null:
return getDepartmentsSuccess(_that.departments);case _SearchDepartmentsSuccess() when searchDepartmentsSuccess != null:
return searchDepartmentsSuccess(_that.departments);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements DepartmentsViewState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DepartmentsViewState.initial()';
}


}




/// @nodoc


class _GetDepartmentsLoading implements DepartmentsViewState {
  const _GetDepartmentsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDepartmentsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DepartmentsViewState.getDepartmentsLoading()';
}


}




/// @nodoc


class _SearchDepartmentsLoading implements DepartmentsViewState {
  const _SearchDepartmentsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchDepartmentsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DepartmentsViewState.searchDepartmentsLoading()';
}


}




/// @nodoc


class _GetDepartmentsFailure implements DepartmentsViewState {
  const _GetDepartmentsFailure({required this.errorMessage});
  

 final  String errorMessage;

/// Create a copy of DepartmentsViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDepartmentsFailureCopyWith<_GetDepartmentsFailure> get copyWith => __$GetDepartmentsFailureCopyWithImpl<_GetDepartmentsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDepartmentsFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'DepartmentsViewState.getDepartmentsFailure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$GetDepartmentsFailureCopyWith<$Res> implements $DepartmentsViewStateCopyWith<$Res> {
  factory _$GetDepartmentsFailureCopyWith(_GetDepartmentsFailure value, $Res Function(_GetDepartmentsFailure) _then) = __$GetDepartmentsFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class __$GetDepartmentsFailureCopyWithImpl<$Res>
    implements _$GetDepartmentsFailureCopyWith<$Res> {
  __$GetDepartmentsFailureCopyWithImpl(this._self, this._then);

  final _GetDepartmentsFailure _self;
  final $Res Function(_GetDepartmentsFailure) _then;

/// Create a copy of DepartmentsViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_GetDepartmentsFailure(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SearchDepartmentsFailure implements DepartmentsViewState {
  const _SearchDepartmentsFailure({required this.errorMessage});
  

 final  String errorMessage;

/// Create a copy of DepartmentsViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchDepartmentsFailureCopyWith<_SearchDepartmentsFailure> get copyWith => __$SearchDepartmentsFailureCopyWithImpl<_SearchDepartmentsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchDepartmentsFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'DepartmentsViewState.searchDepartmentsFailure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SearchDepartmentsFailureCopyWith<$Res> implements $DepartmentsViewStateCopyWith<$Res> {
  factory _$SearchDepartmentsFailureCopyWith(_SearchDepartmentsFailure value, $Res Function(_SearchDepartmentsFailure) _then) = __$SearchDepartmentsFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class __$SearchDepartmentsFailureCopyWithImpl<$Res>
    implements _$SearchDepartmentsFailureCopyWith<$Res> {
  __$SearchDepartmentsFailureCopyWithImpl(this._self, this._then);

  final _SearchDepartmentsFailure _self;
  final $Res Function(_SearchDepartmentsFailure) _then;

/// Create a copy of DepartmentsViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_SearchDepartmentsFailure(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GetDepartmentsSuccess implements DepartmentsViewState {
  const _GetDepartmentsSuccess({required final  List<DepartmentEntity> departments}): _departments = departments;
  

 final  List<DepartmentEntity> _departments;
 List<DepartmentEntity> get departments {
  if (_departments is EqualUnmodifiableListView) return _departments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departments);
}


/// Create a copy of DepartmentsViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDepartmentsSuccessCopyWith<_GetDepartmentsSuccess> get copyWith => __$GetDepartmentsSuccessCopyWithImpl<_GetDepartmentsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDepartmentsSuccess&&const DeepCollectionEquality().equals(other._departments, _departments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_departments));

@override
String toString() {
  return 'DepartmentsViewState.getDepartmentsSuccess(departments: $departments)';
}


}

/// @nodoc
abstract mixin class _$GetDepartmentsSuccessCopyWith<$Res> implements $DepartmentsViewStateCopyWith<$Res> {
  factory _$GetDepartmentsSuccessCopyWith(_GetDepartmentsSuccess value, $Res Function(_GetDepartmentsSuccess) _then) = __$GetDepartmentsSuccessCopyWithImpl;
@useResult
$Res call({
 List<DepartmentEntity> departments
});




}
/// @nodoc
class __$GetDepartmentsSuccessCopyWithImpl<$Res>
    implements _$GetDepartmentsSuccessCopyWith<$Res> {
  __$GetDepartmentsSuccessCopyWithImpl(this._self, this._then);

  final _GetDepartmentsSuccess _self;
  final $Res Function(_GetDepartmentsSuccess) _then;

/// Create a copy of DepartmentsViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? departments = null,}) {
  return _then(_GetDepartmentsSuccess(
departments: null == departments ? _self._departments : departments // ignore: cast_nullable_to_non_nullable
as List<DepartmentEntity>,
  ));
}


}

/// @nodoc


class _SearchDepartmentsSuccess implements DepartmentsViewState {
  const _SearchDepartmentsSuccess({required final  List<DepartmentEntity> departments}): _departments = departments;
  

 final  List<DepartmentEntity> _departments;
 List<DepartmentEntity> get departments {
  if (_departments is EqualUnmodifiableListView) return _departments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departments);
}


/// Create a copy of DepartmentsViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchDepartmentsSuccessCopyWith<_SearchDepartmentsSuccess> get copyWith => __$SearchDepartmentsSuccessCopyWithImpl<_SearchDepartmentsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchDepartmentsSuccess&&const DeepCollectionEquality().equals(other._departments, _departments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_departments));

@override
String toString() {
  return 'DepartmentsViewState.searchDepartmentsSuccess(departments: $departments)';
}


}

/// @nodoc
abstract mixin class _$SearchDepartmentsSuccessCopyWith<$Res> implements $DepartmentsViewStateCopyWith<$Res> {
  factory _$SearchDepartmentsSuccessCopyWith(_SearchDepartmentsSuccess value, $Res Function(_SearchDepartmentsSuccess) _then) = __$SearchDepartmentsSuccessCopyWithImpl;
@useResult
$Res call({
 List<DepartmentEntity> departments
});




}
/// @nodoc
class __$SearchDepartmentsSuccessCopyWithImpl<$Res>
    implements _$SearchDepartmentsSuccessCopyWith<$Res> {
  __$SearchDepartmentsSuccessCopyWithImpl(this._self, this._then);

  final _SearchDepartmentsSuccess _self;
  final $Res Function(_SearchDepartmentsSuccess) _then;

/// Create a copy of DepartmentsViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? departments = null,}) {
  return _then(_SearchDepartmentsSuccess(
departments: null == departments ? _self._departments : departments // ignore: cast_nullable_to_non_nullable
as List<DepartmentEntity>,
  ));
}


}

// dart format on
