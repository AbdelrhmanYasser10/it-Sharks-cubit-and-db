import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cubits/counter_cubit/counter_cubit.dart';


class MultiplyCounterScreen extends StatelessWidget {
  const MultiplyCounterScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        var cubit = CounterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: const Text(
              "Multiply",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${cubit.counter}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 48.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    cubit.multiplyCounter();
                  },
                  //UI
                  child: const Icon(
                    Icons.percent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
