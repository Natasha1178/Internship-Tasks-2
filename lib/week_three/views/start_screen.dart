import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:internshiptask2/week_three/views/task_list_screen.dart";
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}
class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width:double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 243, 239, 58),
            const Color.fromARGB(255, 234, 231, 208),
            const Color.fromARGB(255, 243, 239, 58),
          ],
           begin: Alignment.bottomLeft,
           end: Alignment.topRight,
          )      
           ),
           child: Center(
             child: SingleChildScrollView(
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,                    
                children: [                                          
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: Image(
                    height: 250,
                    width: 300
                    ,
                    image: AssetImage("assets/start.jpg"),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Manage Your All task\n        in one Place",style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)
                          
                ),
                SizedBox(height: 20,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                  border: Border.all(color: Colors.black)),
                  child: IconButton(onPressed: (){
                    Get.off(TaskListScreen());
                  }, icon:Icon(Icons.arrow_forward_outlined,
                  color: Colors.white,)),
               
                  ),
                  
               ],),
             ),
           ),
        ),
    
        
      
    );
  }
}