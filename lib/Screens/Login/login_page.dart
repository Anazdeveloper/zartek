import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek/Screens/User%20Home/user_home_bloc.dart';
import 'package:zartek/Screens/User%20Home/user_home_page.dart';
import 'package:zartek/Services/authentication.dart';
import 'package:zartek/UiComponents/progress.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  bool _isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Center(
              child: Image.asset(
                  'assets/images/firebase.webp',
                height: 300.0,
                width: 300.0,
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              height: 60.0,
              child: FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if(snapshot.hasError) {
                    return Text('Error initializing firebase');
                  } else if(snapshot.connectionState == ConnectionState.done) {
                    return ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )
                          )
                      ),
                      onPressed: () async {
                        User? user = await Authentication.signInWithGoogle(context: context);
                        if(user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content:
                            Text(
                                'Successfully logged in',
                                style: TextStyle(
                                    color: Colors.green
                                )
                            ),
                            ),
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => UserHomeBloc(),child: UserHomePage(user),), ));
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: Image.asset(
                                  'assets/images/googleicon.webp',
                                  height: 30.0,
                                  width: 30.0,
                                ),
                              )),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Google',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Progress();
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              height: 60.0,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )
                    )
                ),
                onPressed: () {},
                child: Stack(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Phone',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}