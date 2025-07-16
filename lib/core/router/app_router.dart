import 'package:go_router/go_router.dart';
import 'package:mvvm/features/home/views/home_screen.dart';
import 'package:mvvm/features/report_problem/models/report_problem.dart';
import '../../features/report_problem/views/report_problem_list_screen.dart';
import '../../features/report_problem/views/report_problem_detail_screen.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/auth/views/profile_screen.dart';
import '../../features/auth/views/splash_screen.dart';
import '../../features/auth/viewmodels/auth_viewmodel.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String home = '/';
  static const String reportProblemDetail = '/report-problem-detail';
  static const String login = '/login';
  static const String profile = '/profile';

  static GoRouter createRouter(AuthViewModel authViewModel) {
    return GoRouter(
      initialLocation: splash,
      refreshListenable:
          authViewModel, // This makes router listen to AuthViewModel changes
      redirect: (context, state) {
        final isInitialized = authViewModel.isInitialized;
        final isLoggedIn = authViewModel.isLoggedIn;
        final currentLocation = state.matchedLocation;

        // Show splash screen while initializing
        if (!isInitialized) {
          return splash;
        }

        // After initialization, redirect based on auth status
        if (isInitialized) {
          // If on splash screen, redirect based on login status
          if (currentLocation == splash) {
            return isLoggedIn ? home : login;
          }

          // If not logged in and not on login page, redirect to login
          if (!isLoggedIn && currentLocation != login) {
            return login;
          }

          // If logged in and on login page, redirect to home
          if (isLoggedIn && currentLocation == login) {
            return home;
          }
        }

        return null;
      },
      routes: [
        GoRoute(
          path: splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(path: login, builder: (context, state) => const LoginScreen()),
        // GoRoute(
        //   path: home,
        //   builder: (context, state) => const ReportProblemListScreen(),
        // ),
        GoRoute(path: home, builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: reportProblemDetail,
          builder: (context, state) {
            final reportProblem = state.extra as ReportProblem?;
            return ReportProblemDetailScreen(reportProblem: reportProblem);
          },
        ),
      ],
    );
  }
}



