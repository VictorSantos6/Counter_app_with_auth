import 'package:counter_app_with_auth/core/constants/app_colors.dart';
import 'package:counter_app_with_auth/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool signIn = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Authentication successful!")),
            );
            return context.go('/counter');
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return _buildAuthForm();
            } else if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildAuthForm();
          },
        ),
      ),
    );
  }

  Widget textField({
    required TextEditingController controller,
    required String name,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: name,
        hintText: "Enter $name",
      ),
    );
  }

  Widget confirmButton({required String confirmation}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            final email = emailController.text.trim();
            final password = passwordController.text.trim();
            final name = nameController.text.trim();

            // Validation
            if (email.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Email and password cannot be empty")),
              );
              return;
            }

            if (confirmation == "Sign in") {
              // Call sign in
              context.read<AuthCubit>().signIn(email: email, password: password);
            } else {
              // Call sign up
              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Name cannot be empty")),
                );
                return;
              }
              context.read<AuthCubit>().signUp(email: email, password: password, name: name);
            }
          },
          child: Container(
            height: 5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.primaryRed,
            ),
            child: Center(
              child: Text(
                confirmation,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        confirmation == "Sign in"
            ? Padding(
                padding: EdgeInsets.only(right: 1.w),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      signIn = !signIn;
                      emailController.clear();
                      passwordController.clear();
                      nameController.clear();
                    });
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "You dont have an account?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(right: 1.w),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      signIn = !signIn;
                      emailController.clear();
                      passwordController.clear();
                      nameController.clear();
                    });
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "You already have an account?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
      ],
    );
  }
  
  _buildAuthForm() {
    return signIn == true
        ? Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 3.w),
              child: Stack(
                children: [
                  Positioned(
                    top: 26.h,
                    left: 0,
                    right: 0,
                    child: Icon(
                      Icons.lock_clock_outlined,
                      size: 150,
                      color: AppColors.primaryRed,
                    ),
                  ),
                  Positioned(
                    top: 57.h,
                    left: 0,
                    right: 0,
                    child: textField(
                      controller: emailController,
                      name: "Email",
                    ),
                  ),
                  Positioned(
                    top: 67.h,
                    left: 0,
                    right: 0,
                    child: textField(
                      controller: passwordController,
                      name: "Password",
                    ),
                  ),
                  Positioned(
                    top: 80.h,
                    left: 5.w,
                    right: 5.w,
                    child: confirmButton(
                      confirmation: "Sign in",
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 3.w),
              child: Stack(
                children: [
                  Positioned(
                    top: 20.h,
                    left: 0,
                    right: 0,
                    child: Icon(
                      Icons.lock_clock_outlined,
                      size: 150,
                      color: AppColors.primaryRed,
                    ),
                  ),
                  Positioned(
                    top: 50.h,
                    left: 0,
                    right: 0,
                    child: textField(
                      controller: nameController,
                      name: "Full Name",
                    ),
                  ),
                  Positioned(
                    top: 60.h,
                    left: 0,
                    right: 0,
                    child: textField(
                      controller: emailController,
                      name: "Email",
                    ),
                  ),
                  Positioned(
                    top: 70.h,
                    left: 0,
                    right: 0,
                    child: textField(
                      controller: passwordController,
                      name: "Password",
                    ),
                  ),
                  Positioned(
                    top: 83.h,
                    left: 5.w,
                    right: 5.w,
                    child: confirmButton(
                      confirmation: "Sign up",
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
