import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/Screens/User%20Home/user_home_bloc.dart';
import 'package:zartek/Screens/User%20Home/user_home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
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
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )
                    )
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => UserHomeBloc(),child: UserHomePage(),), ));
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