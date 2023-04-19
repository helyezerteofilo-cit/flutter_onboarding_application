import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_info.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final usernameController = TextEditingController();

  String username = '';

  @override
  void dispose(){
    usernameController.dispose();
    super.dispose();
  }
  
  Future<void> addUsernameToSF(String user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user',user);
  }

  Future<String> getUsernameValueSF() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user')?? '';
    return user;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 101, 168, 223),
        title: const Text("Login Page"),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Card(
            child: Column(children: [
              Container(
                height: 150,
                width: 150,
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200)),
                //child: Image.asset('assets/imagess/github-logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: TextField(
                  controller: usernameController,
                  style: const TextStyle(
                    color: Colors.black
                    ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    
                    labelText: "User Name",
                    hintText: "Enter valid username"
                  ),
                ),
              ),
              TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                  fixedSize: MaterialStatePropertyAll(Size(90, 40))
                  ),
                child: const Text("Access Info",style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  await addUsernameToSF(usernameController.text);
                  username = await getUsernameValueSF();
                  if (username!= ''){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> UserInfo(username: username)));
                  }
                },
                 
              ),
            ]),
          ),
        ),
      ),
    );
  }
}