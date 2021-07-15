import 'package:flutter/material.dart';
import 'package:flutter_firebase/counter_getX/counter_controller.dart';
import 'package:get/get.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Counter App with getX",
      home: CounterScreen(),
    );
  }
}
class CounterScreen extends StatelessWidget {
  
  final _controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    //print("Call build widget!");
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
      ),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          
          _controller.increment();
        },
        ),

        body: Center(
        child: Obx((){
          //print("Call widget only!");
          return Text(_controller.counter.value.toString(),style: TextStyle(fontSize: 30));
        })
      ),
    );
  }
}