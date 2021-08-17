import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool _isPhone = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  Future phoneLoginUser(String mobile, BuildContext context) async{

    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          
          Navigator.of(context).pop();
          
          UserCredential result = await _auth.signInWithCredential(credential);
          User? user = result.user;

          if(user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(create: (context) => UserHomeBloc(),child: UserHomePage(result.user, _isPhone),))
            );
          } else {
            print('Error');
          }
        },
        verificationFailed: (exception) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                  exception.toString(),
                  style: TextStyle(
                    color: Colors.black
                  ),
                )
            )
          );
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          showDialog(
              context: context,
            barrierDismissible: true,
            builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Give your code?',
                  ),
                  content: Column(
                    children: [
                      TextField(
                        controller: codeController,
                      )
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                        ),
                        onPressed: () async {
                          final code = codeController.text.trim();
                          AuthCredential credential = PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: code
                          );

                         UserCredential result = await _auth.signInWithCredential(credential);
                         User? user = result.user;

                         if(user != null) {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => BlocProvider(create: (context) => UserHomeBloc(),child: UserHomePage(result.user, _isPhone),))
                           );
                         } else {
                           print('Error');
                         }
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ))
                  ],

                );
            }
          );
        },
        codeAutoRetrievalTimeout: (String verificationId){
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        }
    );
  }

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
                    return const Text('Error initializing firebase');
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
                          _isPhone = false;
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => UserHomeBloc(),child: UserHomePage(user, _isPhone),), ));
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: const Text('Enter the phone number'),
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Column(
                              children: [
                                TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                                  ),
                                  onPressed: () {
                                    final phone = phoneController.text.trim();
                                    phoneLoginUser(phone, context);
                                  },
                                  child: const Text(
                                    'Send OTP',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),

                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
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