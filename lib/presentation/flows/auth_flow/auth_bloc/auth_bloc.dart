import 'package:maids_project/core/mediators/bloc_hub/bloc_member.dart';
import 'package:maids_project/core/mediators/communication_types/base_communication.dart';
import 'package:maids_project/data/requests/auth_request.dart';
import 'package:maids_project/domain/usecases/auth_usecases.dart';
import 'package:maids_project/presentation/flows/auth_flow/auth_bloc/auth_event.dart';
import 'package:maids_project/presentation/flows/auth_flow/auth_bloc/auth_state.dart';
import 'package:bloc/bloc.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> with BlocMember
{
  final LoginUseCase loginUsecase;
  AuthBloc(this.loginUsecase): super(const AuthState()){
    on<LogInEvent>(_onLogIn);
  }

  @override
  void receive(String from, CommunicationType data) {

  }

}
extension AuthBlocMappers on AuthBloc {
  void _onLogIn(LogInEvent event, Emitter<AuthState> emit) async {
       emit(state.copyWith(loginStatus: LoginStatus.loading));
       final result=await loginUsecase(LoginParms(loginRequest: LoginRequest(email: event.email,password: event.password)));
       if(result.hasDataOnly)
         {
           emit(state.copyWith(loginStatus: LoginStatus.success));
         }
       else{
         emit(state.copyWith(loginStatus: LoginStatus.error,errorLogin: result.error.toString()));
       }
  }
}