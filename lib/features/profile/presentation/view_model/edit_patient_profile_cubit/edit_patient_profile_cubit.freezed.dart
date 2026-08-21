part of 'edit_patient_profile_cubit.dart';

T _$identity<T>(T value) => value;

mixin _$EditPatientProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditPatientProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditPatientProfileState()';
}


}

class $EditPatientProfileStateCopyWith<$Res>  {
$EditPatientProfileStateCopyWith(EditPatientProfileState _, $Res Function(EditPatientProfileState) __);
}

extension EditPatientProfileStatePatterns on EditPatientProfileState {

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _EditSuccess value)?  editSuccess,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _EditSuccess() when editSuccess != null:
return editSuccess(_that);case _Failure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _EditSuccess value)  editSuccess,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _EditSuccess():
return editSuccess(_that);case _Failure():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _EditSuccess value)?  editSuccess,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _EditSuccess() when editSuccess != null:
return editSuccess(_that);case _Failure() when failure != null:
return failure(_that);case _:
  return null;

}
}

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PatientProfileEntity patientProfileInfo)?  success,TResult Function( PatientProfileEntity patientProfileInfo)?  editSuccess,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.patientProfileInfo);case _EditSuccess() when editSuccess != null:
return editSuccess(_that.patientProfileInfo);case _Failure() when failure != null:
return failure(_that.message);case _:
  return orElse();

}
}

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PatientProfileEntity patientProfileInfo)  success,required TResult Function( PatientProfileEntity patientProfileInfo)  editSuccess,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.patientProfileInfo);case _EditSuccess():
return editSuccess(_that.patientProfileInfo);case _Failure():
return failure(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PatientProfileEntity patientProfileInfo)?  success,TResult? Function( PatientProfileEntity patientProfileInfo)?  editSuccess,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.patientProfileInfo);case _EditSuccess() when editSuccess != null:
return editSuccess(_that.patientProfileInfo);case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

class _Initial implements EditPatientProfileState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditPatientProfileState.initial()';
}


}

class _Loading implements EditPatientProfileState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditPatientProfileState.loading()';
}


}

class _Success implements EditPatientProfileState {
  const _Success(this.patientProfileInfo);
  

 final  PatientProfileEntity patientProfileInfo;

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.patientProfileInfo, patientProfileInfo) || other.patientProfileInfo == patientProfileInfo));
}


@override
int get hashCode => Object.hash(runtimeType,patientProfileInfo);

@override
String toString() {
  return 'EditPatientProfileState.success(patientProfileInfo: $patientProfileInfo)';
}


}

abstract mixin class _$SuccessCopyWith<$Res> implements $EditPatientProfileStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 PatientProfileEntity patientProfileInfo
});




}

class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

@pragma('vm:prefer-inline') $Res call({Object? patientProfileInfo = null,}) {
  return _then(_Success(
null == patientProfileInfo ? _self.patientProfileInfo : patientProfileInfo
as PatientProfileEntity,
  ));
}


}

class _EditSuccess implements EditPatientProfileState {
  const _EditSuccess(this.patientProfileInfo);
  

 final  PatientProfileEntity patientProfileInfo;

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditSuccessCopyWith<_EditSuccess> get copyWith => __$EditSuccessCopyWithImpl<_EditSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditSuccess&&(identical(other.patientProfileInfo, patientProfileInfo) || other.patientProfileInfo == patientProfileInfo));
}


@override
int get hashCode => Object.hash(runtimeType,patientProfileInfo);

@override
String toString() {
  return 'EditPatientProfileState.editSuccess(patientProfileInfo: $patientProfileInfo)';
}


}

abstract mixin class _$EditSuccessCopyWith<$Res> implements $EditPatientProfileStateCopyWith<$Res> {
  factory _$EditSuccessCopyWith(_EditSuccess value, $Res Function(_EditSuccess) _then) = __$EditSuccessCopyWithImpl;
@useResult
$Res call({
 PatientProfileEntity patientProfileInfo
});




}

class __$EditSuccessCopyWithImpl<$Res>
    implements _$EditSuccessCopyWith<$Res> {
  __$EditSuccessCopyWithImpl(this._self, this._then);

  final _EditSuccess _self;
  final $Res Function(_EditSuccess) _then;

@pragma('vm:prefer-inline') $Res call({Object? patientProfileInfo = null,}) {
  return _then(_EditSuccess(
null == patientProfileInfo ? _self.patientProfileInfo : patientProfileInfo
as PatientProfileEntity,
  ));
}


}

class _Failure implements EditPatientProfileState {
  const _Failure(this.message);
  

 final  String message;

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'EditPatientProfileState.failure(message: $message)';
}


}

abstract mixin class _$FailureCopyWith<$Res> implements $EditPatientProfileStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}

class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message
as String,
  ));
}


}

