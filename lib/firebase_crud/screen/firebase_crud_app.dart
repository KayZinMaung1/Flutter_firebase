import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase_crud/screen/add_user_screen.dart';
import 'package:flutter_firebase/firebase_crud/service/data_repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class FirebaseCrudApp extends StatelessWidget {
  const FirebaseCrudApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Firebase Demo App",
      home: FirebaseCrudScreen(),
    );
  }
}
class FirebaseCrudScreen extends StatefulWidget {
  
  @override
  _FirebaseCrudScreenState createState() => _FirebaseCrudScreenState();
}

class _FirebaseCrudScreenState extends State<FirebaseCrudScreen> {
  late DataRepository _dataRepository;
  @override
  void initState() {
    super.initState();
     _dataRepository = DataRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase App"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> AddUserScreen())
          );
        },
        child: Icon(Icons.add),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _dataRepository.readData(),
        builder: ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                var userData = snapshot.data!.docs[index];
                var docId = userData.id;
                return 
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context){
                            return AddUserScreen(
                              name: userData['name'],
                              age: userData['age'],
                              docId: docId
                            );
                          })
                        );
                      },
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                       showDialog(
                         context: context, 
                         builder: (context)=> AlertDialog(
                           title: Text("Delete User"),
                           content: Text("Are you sure?"),
                           actions: [
                             TextButton(
                               onPressed: ()=> Navigator.pop(context), 
                               child: Text("Cancel")),

                              TextButton(
                                onPressed: () async{
                                 await _dataRepository.deleteUser(docId: docId);
                                 Navigator.pop(context);
                                }, 
                                child: Text("Delete",style: TextStyle(color: Colors.red),)
                                )

                           ],
                         )
                       );
                      },
                    ),
                  ],
                  child: ListTile(
                    leading: CircleAvatar(child: Text((index+1).toString()),),
                    title: Text(userData["name"]),
                    subtitle: Text(userData["age"]),
                    trailing: Text("..."),
                    ),
                );
              });
          }
          return Center(
            child: CircularProgressIndicator()
          );
        }
        ),
    )
    );
  }
}
