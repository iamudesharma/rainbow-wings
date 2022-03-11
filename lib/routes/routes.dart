// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
// import 'dart:js';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rainbow_wings/main.dart';
import 'package:rainbow_wings/page/login_page.dart';
import 'package:rainbow_wings/provider/auth_provider.dart';
import 'package:rainbow_wings/respository/auth_respository.dart';
import 'package:rainbow_wings/respositoryImpl/auth_respository_impl.dart';
import 'package:rainbow_wings/routes/routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true, guards: [AuthGuard]),
    AutoRoute(
      page: LoginPage,
    ),
  ],
)
class $AppRouter {}

// class AuthGuard extends AutoRouteGuard {
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {
//     // the navigation is paused until resolver.next() is called with either
//     // true to resume/continue navigation or false to abort navigation
//     //

//     Reader read ;
//     Provider(
//       ((ref) {
//         if (ref.read(authProvider).isLoggedIn() == true) {
//           resolver.next(true);
//         } else {
//           router.push(const LoginRoute());
//         }
//       }),
//     );
//   }
// }

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    AuthProvider authProvider = AuthProvider(AuthRespositoryImpl());

    if (authProvider.isLoggedIn() == true) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(const LoginRoute());
    }
  }
}
