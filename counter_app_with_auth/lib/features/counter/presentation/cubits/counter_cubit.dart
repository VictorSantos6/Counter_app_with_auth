import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  Future<void> increment() async {
    int currentValue = 0;
    if (state is CounterValue) {
      currentValue = (state as CounterValue).value;
    } else if (state is CounterLoaded) {
      currentValue = (state as CounterLoaded).value;
    }
    await updateValue(currentValue + 1);
  }

  Future<void> decrement() async {
    int currentValue = 0;
    if (state is CounterValue) {
      currentValue = (state as CounterValue).value;
    } else if (state is CounterLoaded) {
      currentValue = (state as CounterLoaded).value;
    }
    await updateValue(currentValue - 1);
  }

  Future<void> updateValue(int newValue) async {
    try {
      emit(CounterLoading());
      await FirebaseFirestore.instance
          .collection("counter")
          .doc("current_value")
          .set({"value": newValue, "timestamp": FieldValue.serverTimestamp()});
      emit(CounterLoaded(newValue));
    } on FirebaseException catch (e) {
      emit(
        CounterError(
          error: "Failed to update counter (${e.code}): ${e.message}",
        ),
      );
    } catch (e) {
      emit(
        CounterError(
          error: "There was an error updating the counter value: $e",
        ),
      );
    }
  }
}
