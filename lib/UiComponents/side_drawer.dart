import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zartek/Screens/Login/login_page.dart';
import 'package:zartek/Services/authentication.dart';

class SideDrawer extends StatelessWidget {
  User user;
  bool _isPhone;

  SideDrawer(this.user, this._isPhone);
  @override
  Widget build(BuildContext context) {
   return Drawer(
     child: Column(
       children: [
         SizedBox(
           height: MediaQuery.of(context).size.height * 0.50,
           width: MediaQuery.of(context).size.width,
           child: Container(
             color: Colors.green,
             //height: MediaQuery.of(context).size.height * 0.50,
             child: Column(
               children: [
                 Spacer(),
                 Container(
                   padding: const EdgeInsets.only(bottom: 20.0),
                   child: Text(
                     _isPhone ? user.phoneNumber! : user.displayName!,
                     style: const TextStyle(
                       color: Colors.black,
                       fontSize: 20.0
                     ),
                   ),
                 ),
                 Text(
                   'ID : ${user.uid}',
                   style: const TextStyle(
                       color: Colors.black,
                       fontSize: 15.0
                   ),
                 ),
               ],
             ),
           ),
         ),
         Container(
           padding: const EdgeInsets.only(top: 20.0,left: 20.0,),
           child: GestureDetector(
             onTap: () async {
               await Authentication.signOut(context: context);
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content:
                   Text(
                     'Successfully logged out',
                     style: TextStyle(
                       color: Colors.green
                     )
                   ),
                 ),
               );
               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
             },
             child: Row(
               children: const [
                 Icon(
                   Icons.logout,
                   color: Colors.grey,
                 ),
                 Padding(
                   padding: EdgeInsets.only(left: 20.0),
                   child: Text(
                     'Logout',
                     style: TextStyle(
                       color: Colors.grey
                     ),
                   ),
                 ),
               ],
             ),
           ),
         )
       ],
     ),
   );
  }

}