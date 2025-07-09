import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'features/report_problem/viewmodels/report_problem_viewmodel.dart';
import 'features/auth/viewmodels/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator
  await ServiceLocator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ServiceLocator.get<AuthViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceLocator.get<ReportProblemViewModel>(),
        ),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return MaterialApp.router(
            title: 'Flutter MVVM App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: AppRouter.createRouter(authViewModel),
          );
        },
      ),
    );
  }
}
