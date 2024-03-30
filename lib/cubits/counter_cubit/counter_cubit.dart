import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  int counter = 0;

  // انا محتاج استعمل نفس ال cubit اللي اتعرف في ال main.dart
  static CounterCubit get(context)=>BlocProvider.of(context);

  void incrementCounter(){
    counter++;
    emit(IncrementedCounter());
  }
  void decrementCounter(){
    counter--;
    emit(DecrementedCounter());
  }

  void multiplyCounter(){
    counter *= 2; // مضاعفه الرقم
    emit(MultiplyCounter());
  }
}
