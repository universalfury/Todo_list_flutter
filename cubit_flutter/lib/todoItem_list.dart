import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_flutter/Cubit/todo_cubit.dart';



class TodoItemList extends StatefulWidget {
  // const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TodoItemList> createState() => _TodoItemListState();
}

class _TodoItemListState extends State<TodoItemList> {

  List<Widget> taskList = [];

  TextEditingController _text_controller = TextEditingController();

  void addTaskToList(String text){
    setState(() {
      taskList.add(TaskListTile(text));
    });
  }

  @override
  Widget build(BuildContext context) {
    var newText = '';
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        children: <Widget>[
          SizedBox(height: 80),
          BlocBuilder<TodoCubit, TodoCountState>(
            builder: (context, state){
              return Text(
                'Total Pending Task(s): ${state.counter}',
                style: TextStyle(fontWeight: FontWeight.bold),
              );
              },
          ),
          SizedBox(height: 20),
          SizedBox(
            child: Container(
              height: 600,
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                itemCount: taskList.length,
                shrinkWrap: true,
                itemBuilder: (context,index)=> (taskList[index]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),

              child: Row(mainAxisAlignment: (MainAxisAlignment.end), children: [
                // First child is enter comment text input
                Expanded(
                  child: TextFormField(
                    controller: _text_controller,
                    autocorrect: false,
                    onChanged: (text) {
                      newText = text;
    },
                    decoration: new InputDecoration(
                      labelText: "Some Text",
                      labelStyle:
                      TextStyle(fontSize: 20.0, color: Colors.white),
                      fillColor: Colors.blue,
                      border: OutlineInputBorder(
                        // borderRadius:
                        //     BorderRadius.all(Radius.zero(5.0)),
                          borderSide: BorderSide(color: Colors.amberAccent)),
                    ),
                  ),
                ),
                // Second child is button
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 20.0,
                  onPressed: () {
                    if (newText != '') {
                      setState(() {
                        addTaskToList(newText);
                        _text_controller.clear();
                      });
                      BlocProvider.of<TodoCubit>(context).newTaskAdded();
                    }
                  }
                )
              ])),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

class TaskListTile extends StatefulWidget {
  final String taskTitle;
  TaskListTile(this.taskTitle);
  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.taskTitle,
        style: TextStyle(decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: ListCheckBox(isChecked, (newValue){

        if (isChecked){
          BlocProvider.of<TodoCubit>(context).newTaskAdded();
        }else{
          BlocProvider.of<TodoCubit>(context).removeTask();
        }
        setState(() {
          isChecked = newValue ?? false;
        });
      }),
    );
  }
}

class ListCheckBox extends StatelessWidget {
  final bool checkBoxChecked;
  final ValueChanged<bool?>? onChanged;

  ListCheckBox(this.checkBoxChecked, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checkBoxChecked,
      activeColor: Colors.teal,
      onChanged: onChanged,
    );
  }
}


