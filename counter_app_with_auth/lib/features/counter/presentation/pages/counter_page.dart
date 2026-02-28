import 'package:counter_app_with_auth/features/counter/presentation/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        int displayValue = 0;

        if (state is CounterValue) {
          displayValue = state.value;
        } else if (state is CounterLoaded) {
          displayValue = state.value;
        }

        if (state is CounterLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is CounterError) {
          return Scaffold(body: Center(child: Text(state.error)));
        }

        return Scaffold(
          appBar: AppBar(title: Text("Counter")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$displayValue",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<CounterCubit>().decrement();
                      },
                      child: Text("- Decrement"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CounterCubit>().increment();
                      },
                      child: Text("+ Increment"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
