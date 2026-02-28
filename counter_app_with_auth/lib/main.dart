import 'package:counter_app_with_auth/features/auth/data/respositories/auth_repo_impl.dart';
import 'package:counter_app_with_auth/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:counter_app_with_auth/features/counter/presentation/cubits/counter_cubit.dart';
import 'package:counter_app_with_auth/features/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(repoImpl: AuthRepoImpl())),
        BlocProvider(create: (context) => CounterCubit()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
