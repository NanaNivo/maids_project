class AuthEvent
{

}
class LogInEvent extends AuthEvent
{
  String email;
  String password;
  LogInEvent({required this.email,required this.password});

}
