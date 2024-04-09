import 'package:equatable/equatable.dart';
import 'package:maids_project/core/mediators/bloc_hub/bloc_member.dart';


enum LoginStatus {init,loading,success,error}
class AuthState extends Equatable{
 final LoginStatus loginStatus;
 final String errorLogin;
 const AuthState({this.loginStatus=LoginStatus.init,this.errorLogin=''});

  AuthState copyWith({
    LoginStatus? loginStatus,
    String? errorLogin,
}){
    return AuthState(loginStatus:loginStatus??this.loginStatus,errorLogin: errorLogin??this.errorLogin );
}

  @override
  // TODO: implement props
  List<Object?> get props => [loginStatus,errorLogin];

}