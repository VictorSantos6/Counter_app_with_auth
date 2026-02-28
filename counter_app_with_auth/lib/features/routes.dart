

import 'package:counter_app_with_auth/features/auth/presentation/pages/auth_page.dart';
import 'package:counter_app_with_auth/features/counter/presentation/pages/counter_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>  const AuthPage(),
      routes: [
        GoRoute(
          path: 'counter',
          builder: (context, state) => const CounterPage(),
        )
      ]
    )
  ]
);