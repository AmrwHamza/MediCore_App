part of 'profile_header_info_cubit.dart';

T _$identity<T>(T value) => value;

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

class $ProfileHeaderInfoStateCopyWith<$Res>  {
$ProfileHeaderInfoStateCopyWith(ProfileHeaderInfoState _, $Res Function(ProfileHeaderInfoState) __);
}

extension ProfileHeaderInfoStatePatterns on ProfileHeaderInfoState {

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

class _GetProfileHeaderInfoFailure implements ProfileHeaderInfoState {
  const _GetProfileHeaderInfoFailure({required this.errorMessage});
  

 final  String errorMessage;

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

abstract mixin class _$GetProfileHeaderInfoFailureCopyWith<$Res> implements $ProfileHeaderInfoStateCopyWith<$Res> {
  factory _$GetProfileHeaderInfoFailureCopyWith(_GetProfileHeaderInfoFailure value, $Res Function(_GetProfileHeaderInfoFailure) _then) = __$GetProfileHeaderInfoFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}

class __$GetProfileHeaderInfoFailureCopyWithImpl<$Res>
    implements _$GetProfileHeaderInfoFailureCopyWith<$Res> {
  __$GetProfileHeaderInfoFailureCopyWithImpl(this._self, this._then);

  final _GetProfileHeaderInfoFailure _self;
  final $Res Function(_GetProfileHeaderInfoFailure) _then;

@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_GetProfileHeaderInfoFailure(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage
as String,
  ));
}


}

class _GetProfileHeaderInfoSuccessSuccess implements ProfileHeaderInfoState {
  const _GetProfileHeaderInfoSuccessSuccess({required this.name, required this.email});
  

 final  String name;
 final  String email;

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

abstract mixin class _$GetProfileHeaderInfoSuccessSuccessCopyWith<$Res> implements $ProfileHeaderInfoStateCopyWith<$Res> {
  factory _$GetProfileHeaderInfoSuccessSuccessCopyWith(_GetProfileHeaderInfoSuccessSuccess value, $Res Function(_GetProfileHeaderInfoSuccessSuccess) _then) = __$GetProfileHeaderInfoSuccessSuccessCopyWithImpl;
@useResult
$Res call({
 String name, String email
});




}

class __$GetProfileHeaderInfoSuccessSuccessCopyWithImpl<$Res>
    implements _$GetProfileHeaderInfoSuccessSuccessCopyWith<$Res> {
  __$GetProfileHeaderInfoSuccessSuccessCopyWithImpl(this._self, this._then);

  final _GetProfileHeaderInfoSuccessSuccess _self;
  final $Res Function(_GetProfileHeaderInfoSuccessSuccess) _then;

@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,}) {
  return _then(_GetProfileHeaderInfoSuccessSuccess(
name: null == name ? _self.name : name
as String,email: null == email ? _self.email : email
as String,
  ));
}


}

