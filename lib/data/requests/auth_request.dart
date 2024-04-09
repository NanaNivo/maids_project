import 'package:maids_project/core/request/request.dart';





class LoginRequest extends Request {
  final String email;

  final String password;

  LoginRequest({required this.email, required this.password});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['email']=email;
    map['password']=password;
   return map;
  }
}

