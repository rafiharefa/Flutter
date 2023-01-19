import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:contacts/database/dbservices.dart';
import 'package:contacts/pages/user_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//mapping actions for slidable
enum Actions{delete, copy}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //variable for a value of search bar
  String name = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color.fromRGBO(35, 34, 39, 100),

      appBar: AppBar(
        title: Container(
          height: 37.5,
            child: TextField(
              textAlignVertical: TextAlignVertical(y: -1),
              autofocus: false,
              textAlign: TextAlign.center,
              showCursor: false,
              enableSuggestions: false,
              autocorrect: false,

              cursorColor: Color.fromRGBO(113, 91, 255, 100),
              style: TextStyle(fontSize: 15, color: Colors.white),
              decoration: InputDecoration(

                filled: true,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.transparent), borderRadius: BorderRadius.circular(50) ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: Color.fromRGBO(38, 37, 44, 100),
                prefixIcon: Icon(Icons.search, size: 15, color: Color.fromRGBO(113, 91, 255, 100),)
              ),
              onChanged: (val){
                setState(() {
                  name = val;
                });
              },
            ),
        ),
        // centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Padding(padding: EdgeInsets.only(right: 10),child: IconButton(
              onPressed: (){Navigator.pushNamed(context, '/user');},
              icon: Icon(Icons.add, color: Color.fromRGBO(113, 91, 255, 100)))
          )
        ],

      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child:

        //showing data
        StreamBuilder<QuerySnapshot>(
          stream: Database.getData(),
          builder: (context, snapshot){

            //checking if snapshot has error
            if(snapshot.hasError){
              return Text('Error');
            }

            else if(snapshot.hasData || snapshot.data != null){
              return SlidableAutoCloseBehavior(
                closeWhenOpened: true,
                child: ListView.separated(

                    itemBuilder: (context, index){

                      //mapping data
                      DocumentSnapshot dsData = snapshot.data!.docs[index];
                      String Name = dsData['name'];
                      String Phone = dsData['phone'];
                      String Phone2 = dsData['phone2'];
                      String Email = dsData['email'];

                      //search bar value is empty
                      if(name.isEmpty){
                        return Builder(
                          builder: (context) => Slidable(
                            endActionPane: ActionPane(motion: const StretchMotion(),
                            children: [

                              //delete contact
                              SlidableAction(

                                backgroundColor: Colors.red,
                                icon: Icons.delete,

                                //passing slidable data to function
                                onPressed: (context) {
                                  _onDismissed(index, Actions.delete, Name);

                                  final snackBar = SnackBar(
                                      width: 150,
                                      backgroundColor: Color.fromRGBO(35, 34, 39, 100),

                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                        children: [
                                          Icon(Icons.delete, color: Colors.white, size: 15,),
                                          Text('Contact Deleted',
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white)),
                                        ]),

                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                }),

                              //copy phone number
                              SlidableAction(
                                backgroundColor: Colors.green,
                                icon: Icons.copy,
                                onPressed: (context){

                                  _onDismissed(index, Actions.copy, Phone);

                                  final snackBar = SnackBar(
                                      width: 170,
                                      backgroundColor: Color.fromRGBO(35, 34, 39, 100),

                                      content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children: [
                                        Icon(Icons.copy, color: Colors.white, size: 15,),
                                        Text('Phone Number Copied', style: TextStyle(fontSize: 10, color: Colors.white))
                                      ]),

                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))));

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                  },
                                )]),

                            child: ListTile(

                              leading: CircleAvatar(child: Text('${Name[0]}', style: TextStyle(fontSize: 20, color: Colors.black)), radius: 25,
                                  backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade700),

                              onTap: (){
                                //passing data to EditUserPage
                                var route = new MaterialPageRoute(builder: (BuildContext context) => new EditUserPage(
                                    Name: Name,
                                    Phone: Phone,
                                    Phone2: Phone2,
                                    Email: Email
                                ));
                                Navigator.of(context).push(route);
                              },

                              title: Text(Name, style: TextStyle(fontSize: 20)),
                              textColor: Colors.white,

                            ),
                          ),
                        );
                      }

                      //search bar value is not empty
                      else if(Name.toLowerCase().startsWith(name.toLowerCase())){
                        return Builder(
                          builder: (context) => Slidable(

                            endActionPane: ActionPane(motion: StretchMotion(), children: [

                              //delete contact
                              SlidableAction(

                                backgroundColor: Colors.red,
                                icon: Icons.delete,

                                //passing slidable data to function
                                onPressed: (context) {
                                  _onDismissed(index, Actions.delete, Name);

                                  final snackBar = SnackBar(
                                      width: 150,
                                      backgroundColor: Color.fromRGBO(35, 34, 39, 100),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.delete, color: Colors.white, size: 15,),
                                          Text('Contact Deleted',
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),

                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)
                                          )
                                      )
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                },
                              ),

                              //copy phone number
                              SlidableAction(
                                backgroundColor: Colors.green,

                                icon: Icons.copy,
                                onPressed: (context){
                                  _onDismissed(index, Actions.copy, Phone);

                                  final snackBar = SnackBar(
                                      width: 170,
                                      backgroundColor: Color.fromRGBO(35, 34, 39, 100),
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.copy, color: Colors.white, size: 15,),
                                          Text('Phone Number Copied',
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),

                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)
                                          )
                                      )
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                },
                              )
                            ]),

                            child: ListTile(
                              leading: CircleAvatar(child: Text('${Name[0]}', style: TextStyle(fontSize: 20, color: Colors.black)), radius: 25,
                                  backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade700),

                              onTap: (){

                                //passing data to EditUserPage
                                var route = new MaterialPageRoute(builder: (BuildContext context) => new EditUserPage(
                                    Name: Name,
                                    Phone: Phone,
                                    Phone2: Phone2,
                                    Email: Email
                                ));
                                Navigator.of(context).push(route);
                              },

                              title: Text(Name, style: TextStyle(fontSize: 20)),
                              textColor: Colors.white,

                            ),
                          ),
                        );
                      }

                      else{
                        return Center();
                        }
                      },

                    separatorBuilder: (context, index) => SizedBox(height: 10.0),
                    itemCount: snapshot.data!.docs.length));

            }
            return Center(

              //showing loading progress when datas are not ready
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
              ),
            );
          },
        ),
      ),
    );
  }
}

//slidable function
void _onDismissed(int index, Actions action, String value){

  switch(action){
  //deleting data when the user press delete on slidable
    case Actions.delete: Database.DeleteData(delete: value);
    break;

    case Actions.copy: FlutterClipboard.copy(value);
    break;
  }
}






