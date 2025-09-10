import 'package:go_router/go_router.dart';
import 'package:smart_edu_again/src/core/routes/route_constant.dart';
import 'package:smart_edu_again/src/feature/admin_flow/widget/result_update_form_one.dart';

import '../../feature/admin_flow/admin_home_page.dart';
import '../../feature/admin_flow/widget/enroll_university.dart';
import '../../feature/admin_flow/widget/result_update.dart';
import '../../feature/admin_flow/widget/result_update_form_two.dart';
import '../../feature/admin_flow/widget/signup_body.dart';
import '../../feature/admin_flow/widget/status_body.dart';
import '../../feature/auth_screen/login_page.dart';
import '../../feature/splash_screen/splash_page.dart';
import '../../feature/user_flow/user_home_page.dart';
import '../../feature/user_flow/widget/user_admission_body.dart';
import '../../feature/user_flow/widget/user_info_body.dart';
import '../../feature/user_flow/widget/user_result_body.dart';
import 'build_page_with_transition.dart';

class RouteConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: RouteConst.splash,

    /// Start at the splash auth_screen
    routes: [
      // StatefulShellRoute.indexedStack(
      //   builder: (context, state, navigationShell) =>
      //       BottomNavBar(navigationShell: navigationShell),
      //   branches: [
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: RouteConst.homeScreen,
      //           builder: (context, state) => const HomeScreenViewer(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: RouteConst.jobScreen,
      //           builder: (context, state) => const JobScreen(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: RouteConst.mapScreen,
      //           builder: (context, state) => const MapScreen(),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           path: RouteConst.settingScreen,
      //           builder: (context, state) => const ProfileSettingScreen(),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),


      GoRoute(
        path: RouteConst.splash,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const SplashPage(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.adminHome,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const AdminHomePage(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.login,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const LoginPage(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.signUp,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const signup(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.status,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const status(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.resultUpdate1,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const ResultUpdateFormOne(),
          );
        },
      ),
      GoRoute(
        path: RouteConst.resultUpdate2,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const ResultUpdateFormTwo(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.enroll,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const enroll(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.userHome,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: user_home(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.info,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: user_info(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.admission,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const user_admission(),
          );
        },
      ),

      GoRoute(
        path: RouteConst.result,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            transitionType: PageTransitionType.slideRightToLeft,
            child: const user_result(),
          );
        },
      ),
    ],
  );
}
