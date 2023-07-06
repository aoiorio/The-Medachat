import 'package:flutter/material.dart';
import 'package:medaka/components/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // インスタンスの作成
  final textController = TextEditingController();
  final favoriteFoodController = TextEditingController();
  final prefs = SharedPreferences.getInstance();
  var userName;

  @override
  void initState() {
    super.initState();
    init();
  }

  //画面起動時に読み込むメソッド
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // データの読み込み
      userName = prefs.getString('text');
    });
  }

  // void _setUserName() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _userName = (prefs.getString('name') ?? '');
  //   });
  //   await prefs.setString('name', _userName);
  // }

  // Future<String> _getPrefUserName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return (prefs.getString('name') ?? '');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 186, 187, 194),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  if (userName == '') // nameの中身が空だったら、Set your nameと表示する
                    const Text(
                      "Set your name",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  else // nameの中身があったら、Hi, [そのname]!を表示する
                    Text(
                      "Hi, $userName!",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),

                  const SizedBox(height: 20),
                  // Text(
                  //   'Hi ${_userNameController}!',
                  //   style: const TextStyle(fontFamily: "bold", fontSize: 50.0),
                  // ),
                  const Icon(Icons.account_circle, size: 200),
                  const SizedBox(height: 20),
                  // テキストフィールドを作る(二つ)
                  // userName text field
                  TextField(
                    
                    controller: textController,
                    
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(
                          width: 3,
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "name",
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 20),

                  MyTextField(
                      controller: favoriteFoodController,
                      hintText: "favorite food",
                      obscureText: false),

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 50, width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          // データの保存
                          prefs.setString('text', textController.text);
                          
                          userName = prefs.getString('text')!;
                        },
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          
                          )
                        ),
                        child: const Text("Save", style: TextStyle(fontSize: 18, fontWeight:  FontWeight.bold)),),
                  ),
                      

                  const SizedBox(height: 20),
                  
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
