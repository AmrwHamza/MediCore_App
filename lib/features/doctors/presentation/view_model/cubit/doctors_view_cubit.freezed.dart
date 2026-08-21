part of 'doctors_view_cubit.dart';

T _$identity<T>(T value) => value;

mixin _$DoctorsViewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorsViewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorsViewState()';
}


}

class $DoctorsViewStateCopyWith<$Res>  {
$DoctorsViewStateCopyWith(DoctorsViewState _, $Res Function(DoctorsViewState) __);
}

extension DoctorsViewStatePatterns on DoctorsViewState {

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _GetDoctorsLoading value)?  getDoctorsLoading,TResult Function( _SearchDoctorsLoading value)?  searchDoctorsLoading,TResult Function( _GetDoctorsFailure value)?  getDoctorsFailure,TResult Function( _SearchDoctorsFailure value)?  searchDoctorsFailure,TResult Function( _GetDoctorsSuccess value)?  getDoctorsSuccess,TResult Function( _SearchDoctorsSuccess value)?  searchDoctorsSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GetDoctorsLoading() when getDoctorsLoading != null:
return getDoctorsLoading(_that);case _SearchDoctorsLoading() when searchDoctorsLoading != null:
return searchDoctorsLoading(_that);case _GetDoctorsFailure() when getDoctorsFailure != null:
return getDoctorsFailure(_that);case _SearchDoctorsFailure() when searchDoctorsFailure != null:
return searchDoctorsFailure(_that);case _GetDoctorsSuccess() when getDoctorsSuccess != null:
return getDoctorsSuccess(_that);case _SearchDoctorsSuccess() when searchDoctorsSuccess != null:
return searchDoctorsSuccess(_that);case _:
  return orElse();

}
}

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _GetDoctorsLoading value)  getDoctorsLoading,required TResult Function( _SearchDoctorsLoading value)  searchDoctorsLoading,required TResult Function( _GetDoctorsFailure value)  getDoctorsFailure,required TResult Function( _SearchDoctorsFailure value)  searchDoctorsFailure,required TResult Function( _GetDoctorsSuccess value)  getDoctorsSuccess,required TResult Function( _SearchDoctorsSuccess value)  searchDoctorsSuccess,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _GetDoctorsLoading():
return getDoctorsLoading(_that);case _SearchDoctorsLoading():
return searchDoctorsLoading(_that);case _GetDoctorsFailure():
return getDoctorsFailure(_that);case _SearchDoctorsFailure():
return searchDoctorsFailure(_that);case _GetDoctorsSuccess():
return getDoctorsSuccess(_that);case _SearchDoctorsSuccess():
return searchDoctorsSuccess(_that);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _GetDoctorsLoading value)?  getDoctorsLoading,TResult? Function( _SearchDoctorsLoading value)?  searchDoctorsLoading,TResult? Function( _GetDoctorsFailure value)?  getDoctorsFailure,TResult? Function( _SearchDoctorsFailure value)?  searchDoctorsFailure,TResult? Function( _GetDoctorsSuccess value)?  getDoctorsSuccess,TResult? Function( _SearchDoctorsSuccess value)?  searchDoctorsSuccess,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GetDoctorsLoading() when getDoctorsLoading != null:
return getDoctorsLoading(_that);case _SearchDoctorsLoading() when searchDoctorsLoading != null:
return searchDoctorsLoading(_that);case _GetDoctorsFailure() when getDoctorsFailure != null:
return getDoctorsFailure(_that);case _SearchDoctorsFailure() when searchDoctorsFailure != null:
return searchDoctorsFailure(_that);case _GetDoctorsSuccess() when getDoctorsSuccess != null:
return getDoctorsSuccess(_that);case _SearchDoctorsSuccess() when searchDoctorsSuccess != null:
return searchDoctorsSuccess(_that);case _:
  return null;

}
}

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  getDoctorsLoading,TResult Function()?  searchDoctorsLoading,TResult Function( String errorMessage)?  getDoctorsFailure,TResult Function( String errorMessage)?  searchDoctorsFailure,TResult Function( List<DoctorEntity> doctors)?  getDoctorsSuccess,TResult Function( List<DoctorEntity> doctors)?  searchDoctorsSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GetDoctorsLoading() when getDoctorsLoading != null:
return getDoctorsLoading();case _SearchDoctorsLoading() when searchDoctorsLoading != null:
return searchDoctorsLoading();case _GetDoctorsFailure() when getDoctorsFailure != null:
return getDoctorsFailure(_that.errorMessage);case _SearchDoctorsFailure() when searchDoctorsFailure != null:
return searchDoctorsFailure(_that.errorMessage);case _GetDoctorsSuccess() when getDoctorsSuccess != null:
return getDoctorsSuccess(_that.doctors);case _SearchDoctorsSuccess() when searchDoctorsSuccess != null:
return searchDoctorsSuccess(_that.doctors);case _:
  return orElse();

}
}

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  getDoctorsLoading,required TResult Function()  searchDoctorsLoading,required TResult Function( String errorMessage)  getDoctorsFailure,required TResult Function( String errorMessage)  searchDoctorsFailure,required TResult Function( List<DoctorEntity> doctors)  getDoctorsSuccess,required TResult Function( List<DoctorEntity> doctors)  searchDoctorsSuccess,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _GetDoctorsLoading():
return getDoctorsLoading();case _SearchDoctorsLoading():
return searchDoctorsLoading();case _GetDoctorsFailure():
return getDoctorsFailure(_that.errorMessage);case _SearchDoctorsFailure():
return searchDoctorsFailure(_that.errorMessage);case _GetDoctorsSuccess():
return getDoctorsSuccess(_that.doctors);case _SearchDoctorsSuccess():
return searchDoctorsSuccess(_that.doctors);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  getDoctorsLoading,TResult? Function()?  searchDoctorsLoading,TResult? Function( String errorMessage)?  getDoctorsFailure,TResult? Function( String errorMessage)?  searchDoctorsFailure,TResult? Function( List<DoctorEntity> doctors)?  getDoctorsSuccess,TResult? Function( List<DoctorEntity> doctors)?  searchDoctorsSuccess,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GetDoctorsLoading() when getDoctorsLoading != null:
return getDoctorsLoading();case _SearchDoctorsLoading() when searchDoctorsLoading != null:
return searchDoctorsLoading();case _GetDoctorsFailure() when getDoctorsFailure != null:
return getDoctorsFailure(_that.errorMessage);case _SearchDoctorsFailure() when searchDoctorsFailure != null:
return searchDoctorsFailure(_that.errorMessage);case _GetDoctorsSuccess() when getDoctorsSuccess != null:
return getDoctorsSuccess(_that.doctors);case _SearchDoctorsSuccess() when searchDoctorsSuccess != null:
return searchDoctorsSuccess(_that.doctors);case _:
  return null;

}
}

}

class _Initial implements DoctorsViewState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorsViewState.initial()';
}


}

class _GetDoctorsLoading implements DoctorsViewState {
  const _GetDoctorsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDoctorsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorsViewState.getDoctorsLoading()';
}


}

class _SearchDoctorsLoading implements DoctorsViewState {
  const _SearchDoctorsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchDoctorsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorsViewState.searchDoctorsLoading()';
}


}

class _GetDoctorsFailure implements DoctorsViewState {
  const _GetDoctorsFailure({required this.errorMessage});
  

 final  String errorMessage;

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDoctorsFailureCopyWith<_GetDoctorsFailure> get copyWith => __$GetDoctorsFailureCopyWithImpl<_GetDoctorsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDoctorsFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'DoctorsViewState.getDoctorsFailure(errorMessage: $errorMessage)';
}


}

abstract mixin class _$GetDoctorsFailureCopyWith<$Res> implements $DoctorsViewStateCopyWith<$Res> {
  factory _$GetDoctorsFailureCopyWith(_GetDoctorsFailure value, $Res Function(_GetDoctorsFailure) _then) = __$GetDoctorsFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}

class __$GetDoctorsFailureCopyWithImpl<$Res>
    implements _$GetDoctorsFailureCopyWith<$Res> {
  __$GetDoctorsFailureCopyWithImpl(this._self, this._then);

  final _GetDoctorsFailure _self;
  final $Res Function(_GetDoctorsFailure) _then;

@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_GetDoctorsFailure(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage
as String,
  ));
}


}

class _SearchDoctorsFailure implements DoctorsViewState {
  const _SearchDoctorsFailure({required this.errorMessage});
  

 final  String errorMessage;

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchDoctorsFailureCopyWith<_SearchDoctorsFailure> get copyWith => __$SearchDoctorsFailureCopyWithImpl<_SearchDoctorsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchDoctorsFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'DoctorsViewState.searchDoctorsFailure(errorMessage: $errorMessage)';
}


}

abstract mixin class _$SearchDoctorsFailureCopyWith<$Res> implements $DoctorsViewStateCopyWith<$Res> {
  factory _$SearchDoctorsFailureCopyWith(_SearchDoctorsFailure value, $Res Function(_SearchDoctorsFailure) _then) = __$SearchDoctorsFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}

class __$SearchDoctorsFailureCopyWithImpl<$Res>
    implements _$SearchDoctorsFailureCopyWith<$Res> {
  __$SearchDoctorsFailureCopyWithImpl(this._self, this._then);

  final _SearchDoctorsFailure _self;
  final $Res Function(_SearchDoctorsFailure) _then;

@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_SearchDoctorsFailure(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage
as String,
  ));
}


}

class _GetDoctorsSuccess implements DoctorsViewState {
  const _GetDoctorsSuccess({required final  List<DoctorEntity> doctors}): _doctors = doctors;
  

 final  List<DoctorEntity> _doctors;
 List<DoctorEntity> get doctors {
  if (_doctors is EqualUnmodifiableListView) return _doctors;

  return EqualUnmodifiableListView(_doctors);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDoctorsSuccessCopyWith<_GetDoctorsSuccess> get copyWith => __$GetDoctorsSuccessCopyWithImpl<_GetDoctorsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDoctorsSuccess&&const DeepCollectionEquality().equals(other._doctors, _doctors));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_doctors));

@override
String toString() {
  return 'DoctorsViewState.getDoctorsSuccess(doctors: $doctors)';
}


}

abstract mixin class _$GetDoctorsSuccessCopyWith<$Res> implements $DoctorsViewStateCopyWith<$Res> {
  factory _$GetDoctorsSuccessCopyWith(_GetDoctorsSuccess value, $Res Function(_GetDoctorsSuccess) _then) = __$GetDoctorsSuccessCopyWithImpl;
@useResult
$Res call({
 List<DoctorEntity> doctors
});




}

class __$GetDoctorsSuccessCopyWithImpl<$Res>
    implements _$GetDoctorsSuccessCopyWith<$Res> {
  __$GetDoctorsSuccessCopyWithImpl(this._self, this._then);

  final _GetDoctorsSuccess _self;
  final $Res Function(_GetDoctorsSuccess) _then;

@pragma('vm:prefer-inline') $Res call({Object? doctors = null,}) {
  return _then(_GetDoctorsSuccess(
doctors: null == doctors ? _self._doctors : doctors
as List<DoctorEntity>,
  ));
}


}

class _SearchDoctorsSuccess implements DoctorsViewState {
  const _SearchDoctorsSuccess({required final  List<DoctorEntity> doctors}): _doctors = doctors;
  

 final  List<DoctorEntity> _doctors;
 List<DoctorEntity> get doctors {
  if (_doctors is EqualUnmodifiableListView) return _doctors;

  return EqualUnmodifiableListView(_doctors);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchDoctorsSuccessCopyWith<_SearchDoctorsSuccess> get copyWith => __$SearchDoctorsSuccessCopyWithImpl<_SearchDoctorsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchDoctorsSuccess&&const DeepCollectionEquality().equals(other._doctors, _doctors));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_doctors));

@override
String toString() {
  return 'DoctorsViewState.searchDoctorsSuccess(doctors: $doctors)';
}


}

abstract mixin class _$SearchDoctorsSuccessCopyWith<$Res> implements $DoctorsViewStateCopyWith<$Res> {
  factory _$SearchDoctorsSuccessCopyWith(_SearchDoctorsSuccess value, $Res Function(_SearchDoctorsSuccess) _then) = __$SearchDoctorsSuccessCopyWithImpl;
@useResult
$Res call({
 List<DoctorEntity> doctors
});




}

class __$SearchDoctorsSuccessCopyWithImpl<$Res>
    implements _$SearchDoctorsSuccessCopyWith<$Res> {
  __$SearchDoctorsSuccessCopyWithImpl(this._self, this._then);

  final _SearchDoctorsSuccess _self;
  final $Res Function(_SearchDoctorsSuccess) _then;

@pragma('vm:prefer-inline') $Res call({Object? doctors = null,}) {
  return _then(_SearchDoctorsSuccess(
doctors: null == doctors ? _self._doctors : doctors
as List<DoctorEntity>,
  ));
}


}
