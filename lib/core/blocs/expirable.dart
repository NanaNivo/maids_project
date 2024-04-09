import 'package:maids_project/app+injection/di.dart';
import 'package:maids_project/core/error/http/forbidden_error.dart';
import 'package:maids_project/core/result/result.dart';

// abstract class Expirable {
//   void expire(Result result) {
//     if (result.hasErrorOnly && result.error is ForbiddenError) {
//       locator<AuthBloc>().logout();
//     }
//     return;
//   }
// }
