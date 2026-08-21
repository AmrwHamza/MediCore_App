part of 'edit_profile_cubit.dart';

T _$identity<T>(T value) => value;

mixin _$EditProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState()';
}


}

class $EditProfileStateCopyWith<$Res>  {
$EditProfileStateCopyWith(EditProfileState _, $Res Function(EditProfileState) __);
}

extension EditProfileStatePatterns on EditProfileState {

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _EditSuccess value)?  EditSuccess,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _EditSuccess() when EditSuccess != null:
return EditSuccess(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _EditSuccess value)  EditSuccess,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _EditSuccess():
return EditSuccess(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _EditSuccess value)?  EditSuccess,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _EditSuccess() when EditSuccess != null:
return EditSuccess(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( EditProfileEntity profileInfo)?  success,TResult Function( EditProfileEntity profileInfo)?  EditSuccess,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.profileInfo);case _EditSuccess() when EditSuccess != null:
return EditSuccess(_that.profileInfo);case _Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( EditProfileEntity profileInfo)  success,required TResult Function( EditProfileEntity profileInfo)  EditSuccess,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.profileInfo);case _EditSuccess():
return EditSuccess(_that.profileInfo);case _Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( EditProfileEntity profileInfo)?  success,TResult? Function( EditProfileEntity profileInfo)?  EditSuccess,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.profileInfo);case _EditSuccess() when EditSuccess != null:
return EditSuccess(_that.profileInfo);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

class _Initial implements EditProfileState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState.initial()';
}


}

class _Loading implements EditProfileState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState.loading()';
}


}

class _Success implements EditProfileState {
  const _Success(this.profileInfo);
  

 final  EditProfileEntity profileInfo;

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.profileInfo, profileInfo) || other.profileInfo == profileInfo));
}


@override
int get hashCode => Object.hash(runtimeType,profileInfo);

@override
String toString() {
  return 'EditProfileState.success(profileInfo: $profileInfo)';
}


}

abstract mixin class _$SuccessCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 EditProfileEntity profileInfo
});




}

class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

@pragma('vm:prefer-inline') $Res call({Object? profileInfo = null,}) {
  return _then(_Success(
null == profileInfo ? _self.profileInfo : profileInfo
as EditProfileEntity,
  ));
}


}

class _EditSuccess implements EditProfileState {
  const _EditSuccess(this.profileInfo);
  

 final  EditProfileEntity profileInfo;

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditSuccessCopyWith<_EditSuccess> get copyWith => __$EditSuccessCopyWithImpl<_EditSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditSuccess&&(identical(other.profileInfo, profileInfo) || other.profileInfo == profileInfo));
}


@override
int get hashCode => Object.hash(runtimeType,profileInfo);

@override
String toString() {
  return 'EditProfileState.EditSuccess(profileInfo: $profileInfo)';
}


}

abstract mixin class _$EditSuccessCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$EditSuccessCopyWith(_EditSuccess value, $Res Function(_EditSuccess) _then) = __$EditSuccessCopyWithImpl;
@useResult
$Res call({
 EditProfileEntity profileInfo
});




}

class __$EditSuccessCopyWithImpl<$Res>
    implements _$EditSuccessCopyWith<$Res> {
  __$EditSuccessCopyWithImpl(this._self, this._then);

  final _EditSuccess _self;
  final $Res Function(_EditSuccess) _then;

@pragma('vm:prefer-inline') $Res call({Object? profileInfo = null,}) {
  return _then(_EditSuccess(
null == profileInfo ? _self.profileInfo : profileInfo
as EditProfileEntity,
  ));
}


}

class _Error implements EditProfileState {
  const _Error(this.message);
  

 final  String message;

@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'EditProfileState.error(message: $message)';
}


}

abstract mixin class _$ErrorCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}

class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message
as String,
  ));
}


}

