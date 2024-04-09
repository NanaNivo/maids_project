import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maids_project/presentation/flows/auth_flow/login_page.dart';
import 'package:maids_project/presentation/flows/auth_flow/register_page.dart';

import 'package:maids_project/presentation/flows/root_flow/screens/root_page.dart';
import 'package:maids_project/presentation/flows/startup_flow/screens/splash_screen.dart';
import 'package:maids_project/presentation/flows/task_flow/screen/task_screeen.dart';

import '../../app+injection/app.dart';

import '../../app+injection/di.dart';

import '../blocs/application_bloc/app_bloc.dart';
import '../mediators/communication_types/AppStatus.dart';
import '../resources/colors.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionNavigatorKey = GlobalKey<NavigatorState>();

class RoutesPath {
  static String get splashScreen => '/';

  static String get welcomePage => '/welcome';

  static String get loginPage => '/auth';
  static String get taskPage=>'/task';

  static String get forgetPasswordPage => '$loginPage/forget-password';

  static String get register => '$loginPage/register';

  static String get verifyCodePage => '$forgetPasswordPage/verify-code';

  static String get resetPasswordPage => '$verifyCodePage/reset-password';

  static String get changePasswordSuccessPage =>
      '$resetPasswordPage/change-success';

  static String get rootPage => '/root';
  static String get cartPage => '/cart';

  static String get userPage => '/user';



  static String get home2 => '$rootPage/home2';

  static String get category => '/category';
  static String get products => '$category/products';
  static String get productDetails => '$products/product-details';


  static String get categoryDetailPage => '/category/detail';

  static String get bag => '/bag';

  static String get preCheckoutForm => '$bag/pre-checkout-form';

  static String get deliveryMethod => '$preCheckoutForm/delivery-method';

  static String get deliveryStores => '$deliveryMethod/delivery-stores';

  static String get confirmDetails => '$deliveryStores/confirm-details';

 // static String get products => '/products';

  static String get wishList => '/wishlist';

  static String get profilePage => '/profile';

  static String get currencies => '$profilePage/currencies';

  static String get privacyPolicy => '$profilePage/privacyPolicy';

  static String get stores => '$profilePage/stores';

  static String get mapStores => '$stores/mapScreen';

  static String get filters => '$products/filters';

  static String get contactUs => '$profilePage/contactUs';

  static String get editProfile => '/profile/editProfile';

  static String get registerStep2 => '$loginPage/register/register2';

  // static String get resetPasswordConfirm =>'reset-confirm';
  static String get changePasswordConfirm =>
      '$forgetPasswordPage/reset-confirm';

  static String get orders => '$profilePage/orders';

  static String get detailedOrder => '$orders/detailedOrder';
}

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  routes: routes,
  initialLocation: RoutesPath.splashScreen,
  refreshListenable: GoRouterRefreshStream(locator<AppBloc>().stream),
);

final List<RouteBase> routes = [
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    name: "splash",
    path: "/",
    builder: (context, state) {
      print('ddddddddddd');
      return const SplashScreen();
    },
    redirect: (context, goState) {
      if (locator<AppBloc>().state.appStatus == Status.unauthorized &&
          goState.location == RoutesPath.splashScreen) {
        print(
            'splash splash splash splash ${locator<AppBloc>().state.isFirstTime} ${goState.location == RoutesPath.splashScreen} ${locator<AppBloc>().state.appStatus} ${goState.matchedLocation}');

        return RoutesPath.loginPage;
      }
      return RoutesPath.taskPage;
    },
  ),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: 'loginScreen',
      path: '/auth',
      builder: (context, state) => LogInPage(),
      redirect: (context, goRouterState) {
        print('authauthauth');
        if (locator<AppBloc>().state.appStatus == Status.authorized &&
            goRouterState.path == RoutesPath.loginPage) {
          //return RoutesPath.rootPage;
        }
        return null;
      },
      routes: [
        GoRoute(
            parentNavigatorKey: rootNavigatorKey,
            name: 'RegisterScreen',
            path: 'register',
            builder: (context, state) => RegisterPage(),
            routes: [

            ]),
      ]),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: 'taskScreen',
      path: '/task',
      builder: (context, state) => TaskScreen(),
      redirect: (context, goRouterState) {

        if (locator<AppBloc>().state.appStatus == Status.authorized &&
            goRouterState.path == RoutesPath.loginPage) {
          //return RoutesPath.rootPage;
        }
        return null;
      },
      routes: [

      ]),
  ShellRoute(
    builder: (context, state, child) {
      Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
      return RootPageWidget(
        navigationShell: child,
        index: extra == null ? 0 : extra['index'] ?? 0,
      );
    },
    routes: [
      GoRoute(
          path: '/root',
          builder: (context, state) {
            return Container();
          },
          routes: [

          ],
          redirect: (context, goRouterState) {
            print('dddddddddddHome${goRouterState}');
            if (locator<AppBloc>().state.appStatus == Status.unauthorized) {
              //  return RoutesPath.loginPage;
            }
            return null;
          }),
      GoRoute(
          path: '/category',
          builder: (context, state) {
          //  return CategoryPage();
            return Container();
          },
          routes: [
            GoRoute(path: 'products',
              builder: (context,state){
                Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
              //  return ProductPage(categoryId: extra!['id'],);
                return Container();

              },
                routes: [
                  GoRoute(
                    path: 'product-details',
                    builder: (context, state) {
                      Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
                     // return ProductDetieles(slug: extra!['slug'],);
                      return Container();

                    },
                  )
                ],
              ),

          ],
          redirect: (context, goRouterState) {
            print('dddddddddddHome${goRouterState}');
            if (locator<AppBloc>().state.appStatus == Status.unauthorized) {
              //  return RoutesPath.loginPage;
            }
            return null;
          }),
      GoRoute(
          path: '/cart',
          builder: (context, state) {
         //   return CartPage();
            return Container();
          },
          routes: [],
          redirect: (context, goRouterState) {
            print('dddddddddddHome${goRouterState}');
            if (locator<AppBloc>().state.appStatus == Status.unauthorized) {
              //  return RoutesPath.loginPage;
            }
            return null;
          }),
      GoRoute(
          path: '/user',
          builder: (context, state) {
            return LogInPage();
          },
          routes: [],
          redirect: (context, goRouterState) {
            print('dddddddddddHome${goRouterState}');
            if (locator<AppBloc>().state.appStatus == Status.unauthorized) {
              //  return RoutesPath.loginPage;
            }
            return null;
          }),

           GoRoute(
          path: '/user',
          builder: (context, state) {
          //  return ProfileScreen();
            return Container();
          })
    ],
  ),
];

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<Status> _subscription;

  GoRouterRefreshStream(Stream<AppState> stream) {
    notifyListeners();
    _subscription = stream
        .asBroadcastStream()
        .map((AppState event) => event.appStatus)
        .listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
