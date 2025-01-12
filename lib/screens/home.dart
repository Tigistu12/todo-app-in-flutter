
// import 'dart:ffi';

import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constraints/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
final todoList = ToDo.todoList();
 List<ToDo> _foundToDo = [];
final _todoController = TextEditingController();

@override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: tdBGcolor,
    appBar: AppBar(
      backgroundColor: tdBGcolor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Icon(
          Icons.menu,
          color:tdBlack, 
          size:30.0,
        ),
        Container(
          height: 40.0,
          width: 40.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('images/avatar.png'),),
        )
      ]),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
               vertical: 15
               ),
            child: Column(
              children: [
                SearchBar(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            
                          ),
                        ),
                      ),
          
                      for(ToDo todo in _foundToDo.reversed)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                      
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                    ),
                   padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),],
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none
                      ),
                    ),
                    ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        ),
                        child: ElevatedButton(
                          child: Text(
                            '+', 
                            style: TextStyle(
                              fontSize:40,
                              ),
                              ),
                          onPressed: (){
                            setState(() {
                              todoList.add(ToDo(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                               todoText: _todoController.text,
                               )); 
                            });
                             _todoController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tdBlue,
                            minimumSize: Size(60, 60),
                            elevation: 10,
                          ),
                          ),
                    )
            ],),
          )
        ],
      ),
  );
}
void _handleToDoChange(ToDo todo){
  setState(() {
      todo.isDone = !todo.isDone;

  }); 
}
void _deleteToDoItem(String id){
  setState(() {
      todoList.removeWhere((item) => item.id == id);
  });
}

void _addToDoItem(String toDo){
  setState(() {
    todoList.add(ToDo(
  id: DateTime.now().millisecondsSinceEpoch.toString(),
   todoText: toDo,
   )
   );
  });
_todoController.clear();
}

void _runFilter(String enteredkeyword){
  List<ToDo> results = [];
  if(enteredkeyword. isEmpty){
    results = todoList;
  }
  else{
    results = todoList
    .where((item) => item.todoText!
    .toLowerCase()
    .contains(enteredkeyword.toLowerCase()))
    .toList();
  }
setState(() {
  _foundToDo = results;
});
}


Widget SearchBar(){
  return Container(
              padding:EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
                  child:TextField(
                    onChanged: (Value) => _runFilter(Value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: tdBlack,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20, 
                        minWidth: 25
                        ),
                    border: InputBorder.none,
                    hintText: 'search',
                    hintStyle: TextStyle(color: tdGrey),

                    
                    ),
                  ),
    );
}
}