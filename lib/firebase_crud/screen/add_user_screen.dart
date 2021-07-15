import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/firebase_crud/service/data_repository.dart';

class AddUserScreen extends StatefulWidget {
  
   final String? name;
   final String? age;
   final  docId;

  const AddUserScreen({Key? key, this.name, this.age, this.docId}): super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {

  late DataRepository _dataRepository;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _dataRepository = DataRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.name != null){
      _nameController.text = widget.name!;
      _ageController.text = widget.age!;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name != null ? "Edit User": "Add New User"),
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),

        child: Form(
          key: _formKey,
          child: Column(
            
            children: [
              SizedBox(
                height: 50,
              ),
              TextFormField(
                validator: (text){
                  if(text!.isEmpty) {
                     return "Text is Empty!";
                  }
                  else if(!(text.length > 2)){
                    return "Enter at least 3 characters!";
                  }
                  else{
                    return null;
                  }
                },
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter name here",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (text){
                  if(text!.isEmpty){
                    return "Text is Empty!";
                  }
                  else{
                    return null;
                  }
                },
                inputFormatters: [LengthLimitingTextInputFormatter(3)],
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: "Enter age here",
                  labelText: "Age",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                 ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                onPressed: (){
                    if(_formKey.currentState!.validate()){
                      var name = _nameController.text;
                    var age = _ageController.text;
          
                    if(widget.name != null){
                        _dataRepository.updateData(name: name, age: age, docId: widget.docId);
                        Navigator.pop(context);
                    }else{
                      //print("Name is ${name}, Age is ${age}");
                      _dataRepository.addData(name: name,age: age);
                      Navigator.pop(context);
                    }
                    
                  }
                },
                  
                child: Text("Save")
              ),
              )
              
            ],),
        ),
      ),
    );
  }
}