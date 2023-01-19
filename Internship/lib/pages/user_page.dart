import 'package:contacts/database/data_class.dart';
import 'package:contacts/database/dbservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var heightScreen = mediaQueryData.size.height;

    return Scaffold(

      backgroundColor: Color.fromRGBO(35, 34, 39, 100),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Create Contact'),
            IconButton(onPressed: (){

              //create new data
              final newData = itemContact(
                  itemName: nameController.text,
                  itemPhone: phoneController.text,
                  itemPhone2: phone2Controller.text,
                  itemEmail: emailController.text,
              );

              //passing data to dbServices
              Database.CreateData(item: newData);

              final snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)
                    )
                ),
                width: 150,
                backgroundColor: Color.fromRGBO(35, 34, 39, 100),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.person_outline_outlined, color: Colors.white, size: 15,),
                    Text('Contact Created',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showSnackBar(snackBar);

              //back to HomePage
              Navigator.pop(context);
            },
              icon: Icon(Icons.check, color: Color.fromRGBO(113, 91, 255, 100)),iconSize: 27)]
        ),
      ),

      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: heightScreen),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                SizedBox(height: 10),

                InkWell(
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(113, 91, 255, 100),
                    radius: 50,
                    child: Icon(Icons.person_outline_outlined, size: 50, color: Colors.white,),
                  ),
                ),

                SizedBox(height: 40),

                //name texfield
                TextField(


                  enableSuggestions: false,
                  showCursor: false,
                  autocorrect: false,

                  onChanged: (value){
                    nameController.value = TextEditingValue(
                      text: capitalizeAllWord(value),
                      selection: nameController.selection
                    );
                  },

                  style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
                  cursorColor: Color.fromRGBO(113, 91, 255, 100),
                  controller: nameController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.white, size: 25),
                      labelText: 'Name',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Color.fromRGBO(113, 91, 255, 100)), borderRadius: BorderRadius.circular(10.0)
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)),
                        borderRadius: BorderRadius.circular(15))

                  ),
                ),

                SizedBox(height: 20),

                //phone textfield
                TextField(
                  enableSuggestions: false,
                  showCursor: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
                  cursorColor: Color.fromRGBO(113, 91, 255, 100),
                  controller: phoneController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone, color: Colors.white, size: 25),
                      labelText: 'Phone Number',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Color.fromRGBO(113, 91, 255, 100)), borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),

                SizedBox(height: 20),

                //phone 2 textfield
                TextField(
                  enableSuggestions: false,
                  showCursor: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
                  cursorColor: Color.fromRGBO(113, 91, 255, 100),
                  controller: phone2Controller,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone, color: Colors.white, size: 25),
                      labelText: 'Phone Number 2',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)), borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),

                SizedBox(height: 20),

                //email textfield
                TextField(
                  enableSuggestions: false,
                  showCursor: false,
                  autocorrect: false,
                  style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
                  cursorColor: Color.fromRGBO(113, 91, 255, 100),
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email, color: Colors.white, size: 25),
                      labelText: 'Email Address',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Color.fromRGBO(113, 91, 255, 100)), borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditUserPage extends StatefulWidget {
  final String Name;
  final String Phone;
  final String Phone2;
  final String Email;

  const EditUserPage({Key? key,
    required this.Name,
    required this.Phone,
    required this.Phone2,
    required this.Email
  }) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    nameController.text = widget.Name;
    phoneController.text = widget.Phone;
    phone2Controller.text = widget.Phone2;
    emailController.text = widget.Email;

    var mediaQueryData = MediaQuery.of(context);
    var heightScreen = mediaQueryData.size.height;

    return Scaffold(

      backgroundColor: Color.fromRGBO(35, 34, 39, 100),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Edit Contact'),
            IconButton(onPressed: (){

              //update new Data
              final newData = itemContact(
                  itemName: nameController.text,
                  itemPhone: phoneController.text,
                  itemPhone2: phone2Controller.text,
                  itemEmail: emailController.text,
              );

              //passing data to dbServices
              Database.UpdateData(item: newData);

              final snackBar = SnackBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)
                    )
                ),
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                width: 150,
                backgroundColor: Color.fromRGBO(35, 34, 39, 100),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.edit, color: Colors.white, size: 15,),
                    Text('Contact Updated',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showSnackBar(snackBar);

              Navigator.pop(context);

            },
              icon: Icon(Icons.check, color: Color.fromRGBO(113, 91, 255, 100)), iconSize: 27,
            )
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: heightScreen),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [

                CircleAvatar(child: Text('${widget.Name[0]}',style: TextStyle(
                  fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white
                ),
                ),
                  radius: 50, backgroundColor: Color.fromRGBO(113, 91, 255, 100),
                ),
                SizedBox(height: 20),

                Text(widget.Name ,style: TextStyle(fontSize: 30 , color: Colors.white)),

                SizedBox(height: 20),

                //phone textfield
                TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  showCursor: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
                  cursorColor: Color.fromRGBO(113, 91, 255, 100),
                  controller: phoneController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone, color: Colors.white, size: 25),
                      suffixIcon: IconButton(
                          onPressed: (){
                        FlutterClipboard.copy(phoneController.text);

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
                          icon: Icon(Icons.copy,
                              color: Colors.white)),

                      labelText: 'Phone Number',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Color.fromRGBO(113, 91, 255, 100)), borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),

                SizedBox(height: 20),

                //phone 2 textfield
                TextField(
                  enableSuggestions: false,
                  showCursor: false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
                  cursorColor: Color.fromRGBO(113, 91, 255, 100),
                  controller: phone2Controller,
                  decoration: InputDecoration(

                      icon: Icon(Icons.phone, color: Colors.white, size: 25),
                      suffixIcon: IconButton(
                          onPressed: (){
                            FlutterClipboard.copy(phone2Controller.text);

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
                          icon: Icon(Icons.copy,
                              color: Colors.white)),

                      labelText: 'Phone Number 2',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Color.fromRGBO(113, 91, 255, 100)), borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),

                SizedBox(height: 20),

                //email textfield
                TextField(
                  enableSuggestions: false,
                  showCursor: false,
                  autocorrect: false,
                  style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
                  cursorColor: Color.fromRGBO(113, 91, 255, 100),
                  controller: emailController,
                  decoration: InputDecoration(

                      icon: Icon(Icons.email, color: Colors.white, size: 25),
                      suffixIcon: IconButton(
                          onPressed: (){
                            FlutterClipboard.copy(emailController.text);

                            final snackBar = SnackBar(
                                width: 170,
                                backgroundColor: Color.fromRGBO(35, 34, 39, 100),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.email_outlined, color: Colors.white, size: 15,),
                                    Text('Email Address Copied',
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
                          icon: Icon(Icons.copy,
                              color: Colors.white)),

                      labelText: 'Email Address',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0, color: Color.fromRGBO(113, 91, 255, 100)), borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0,color: Color.fromRGBO(113, 91, 255, 100)),
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),

                SizedBox(height: 40),

                FloatingActionButton.extended(onPressed: (){
                  Database.DeleteData(delete: widget.Name);

                  final snackBar = SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        )
                    ),
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
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
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentMaterialBanner()
                    ..showSnackBar(snackBar);

                  Navigator.pop(context);
                },

                  icon: Icon(Icons.delete, size: 15),
                  label: Text('delete contact', style: TextStyle(fontSize: 15, color: Colors.white)),
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(113, 91, 255, 100),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}

String capitalizeAllWord(String value) {
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " ") {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
    }
  }
  return result;
}



