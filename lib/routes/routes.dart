import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_aqua_cart/constants/route_constants.dart';
import 'package:test_aqua_cart/models/issue_model.dart';
import 'package:test_aqua_cart/screens/home_screen.dart';
import 'package:test_aqua_cart/screens/issue_details_screen.dart';
import 'package:test_aqua_cart/screens/login_screen.dart';
import 'package:test_aqua_cart/screens/splash_screen.dart';
import 'package:test_aqua_cart/services/auth_services.dart';

final routes = GoRouter(
  // This is the initial location where user will be redirected initially
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const CustomSplashScreen();
      },
      routes: [
        GoRoute(
          path: 'login',
          name: RouteConstants.loginScreenPath,
          builder: (context, state) {
            return const LoginScreen();
          },
          routes: const [
            // GoRoute(
            //   path: 'forgotpassword',
            //   name: RouteConstants.forgotPasswordScreenPath,
            //   builder: (context, state) {
            //     return Container();
            //   },
            //   routes: const [],
            // ),
            // GoRoute(
            //   path: 'signup',
            //   name: RouteConstants.signupScreenPath,
            //   builder: (context, state) {
            //     return Container();
            //   },
            //   routes: const [],
            // )
          ],
          redirect: (context, state) {
            // Redirect user to the home screen if the user is logged in.
            var res = context.read<AuthService>().currentUser;
            if (res != null) {
              return RouteConstants.homeScreenPath;
            }
            return RouteConstants.loginScreenPath;
          },
        ),
        GoRoute(
            path: 'homescreen',
            builder: (context, state) {
              return const HomeScreen();
            },
            routes: [
              GoRoute(
                  path: 'issuedetails',
                  builder: (context, state) {
                    IssuesModel model = state.extra as IssuesModel;
                    return IssueDetailsScreen(
                      issuesModel: model,
                    );
                  },
                  routes: const [])
            ])
      ], // Initial Path Ends here
    ),
  ],
);
