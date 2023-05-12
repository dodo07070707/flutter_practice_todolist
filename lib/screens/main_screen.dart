import 'package:flutter/material.dart';

//class Todo {
// todo를 입력받을 클래스 (변수형식) 선언 , 어떻게 쓰는지 잘 모르겠어서 map으로 대체
// final String title;
// final String description;

// Todo({required this.title, required this.description});
//}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

//color definition
int kPrimaryColor = 0xFFF6AD02;
int kBgColor = 0xFF191919;

//

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> todos = [];
  //textfield에서 입력받는 문자열, 리스트
  String title = "";
  String description = "";
  String searching = "";
  void toggleTodoCompleted(int index) {
    setState(() {
      todos[index]['completed'] =
          !(todos[index]['completed'] as bool? ?? false);
    });
    if (todos[index]['completed']) {
      // 완료된 아이템을 리스트의 맨 아래로 이동
      Map<String, dynamic> completedTodo = todos.removeAt(index);
      todos.add(completedTodo);
    }
    if (!todos[index]['completed']) {
      // 완료되지 않은 아이템을 리스트의 맨 위로 이동
      Map<String, dynamic> incompleteTodo = todos.removeAt(index);
      todos.insert(0, incompleteTodo);
    }
  }

  void removeTodoItem(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: Color(kBgColor),
          ),
          child: AlertDialog(
            title: Text(
              "Add Todo",
              style: TextStyle(
                color: Color(kPrimaryColor),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Type Title",
                    hintStyle: TextStyle(
                      color: Color(kPrimaryColor).withOpacity(0.6),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(kPrimaryColor).withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    // 입력중 text color
                    color: Color(kPrimaryColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Type description",
                    hintStyle: TextStyle(
                      color: Color(kPrimaryColor).withOpacity(0.6),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(kPrimaryColor).withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    // 입력중 text color
                    color: Color(kPrimaryColor),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(Color(kPrimaryColor))),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(kPrimaryColor)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: const Text("Ok"),
                onPressed: () {
                  setState(() {
                    todos.insert(0, {
                      'title': title,
                      'description': description,
                      'completed': false, // 'completed' 값을 false로 초기화
                    });
                  });
                  // 다이얼로그 닫기
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(kBgColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(kBgColor),
          elevation: 0,
          toolbarHeight: 60,
          title: Text(
            'Todo List',
            style: TextStyle(
              fontFamily: 'GmarketSansTTF',
              fontWeight: FontWeight.bold,
              color: Color(kPrimaryColor),
              fontSize: 17,
            ),
          ),
          leading: const Icon(
            Icons.menu_rounded,
            size: 26.5,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.account_circle_outlined,
                size: 26.5,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                    //입력 전 디자인
                    hintText: "Find your Todo",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(kPrimaryColor),
                    ),
                    suffixIcon: const Icon(Icons.search),
                    suffixIconColor: Color(kPrimaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Color(kPrimaryColor),
                      ),
                      borderRadius: BorderRadius.circular(18.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Color(kPrimaryColor),
                      ),
                      borderRadius: BorderRadius.circular(18.5),
                    ),
                  ),
                  style: TextStyle(
                    // 입력 중 글자 색
                    color: Color(kPrimaryColor),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searching = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: SizedBox(
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'All Todo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontFamily: "GmarketSansTTF",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final todo = todos[index];
                      final bool isCompleted =
                          todo['completed'] ?? false; //할 일이 완료되었는지 여부
                      if (title.isNotEmpty &&
                          !todo['title']
                              .toLowerCase()
                              .contains(searching.toLowerCase())) {
                        return const SizedBox.shrink(); // 검색어가 포함되지 않은 항목 숨기기
                      }
                      return Dismissible(
                        key: Key(todo['title']),
                        direction: DismissDirection.startToEnd, // 오른쪽으로 밀때
                        onDismissed: (direction) {
                          // 삭제하기
                          if (direction == DismissDirection.startToEnd) {
                            removeTodoItem(index);
                          }
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), // 뒷배경 둥글게
                            color: Colors.red,
                          ),
                          alignment: Alignment.centerRight, // 아이콘을 오른쪽 가운데
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20), //아이콘 PADDING
                          child: const Icon(Icons.delete_outline_rounded,
                              color: Colors.white),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // 원하는 라운드 모서리 반지름 값 설정
                            side: BorderSide(
                              color: isCompleted
                                  ? const Color(0xFFF7C34C)
                                  : Color(kPrimaryColor),
                              width: 2,
                            ), // 원하는 모서리 색상 및 두께 설정
                          ),
                          color: Color(kBgColor),
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(
                                color: isCompleted ? Colors.grey : Colors.white,
                                isCompleted
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank_rounded,
                                size: 35,
                              ),
                              onPressed: () => toggleTodoCompleted(index),
                            ),
                            title: Text(
                              todo['title'] ?? '',
                              style: TextStyle(
                                color: isCompleted ? Colors.grey : Colors.white,
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ), // ?? '' 는 문자열이 null일 경우를 방지해 빈 문자열로 대체
                            subtitle: Text(
                              todo['description'] ?? '',
                              style: TextStyle(
                                color: isCompleted
                                    ? Colors.grey
                                    : Colors.grey[300],
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ), // ?? ''
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: isCompleted ? Colors.grey : Colors.white,
                              ),
                              onPressed: () => removeTodoItem(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(kPrimaryColor),
                width: 2,
              )),
          child: FloatingActionButton(
            backgroundColor: Color(kBgColor),
            foregroundColor: Color(kPrimaryColor),
            elevation: 20,
            onPressed: _showDialog,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
