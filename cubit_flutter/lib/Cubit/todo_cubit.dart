import 'package:bloc/bloc.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoCountState>{
  TodoCubit() : super(TodoCountState(counter: 0));

  void newTaskAdded() => emit(TodoCountState(counter: state.counter + 1));
  void removeTask() => emit(TodoCountState(counter: state.counter - 1));
}