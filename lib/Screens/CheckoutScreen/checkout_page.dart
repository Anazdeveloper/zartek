import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/Modals/restaurant_modal.dart';
import 'package:zartek/Screens/User%20Home/user_home_bloc.dart';
import 'package:zartek/Screens/User%20Home/user_home_page.dart';

class CheckoutPage extends StatefulWidget {
  final List<CategoryDishes>? dishes;
  final int? items;
  final User? user;

  CheckoutPage(this.dishes, this.items, this.user);

  @override
  State<StatefulWidget> createState() {
    return CheckoutPageState();
  }
}

class CheckoutPageState extends State<CheckoutPage> {
  late List<CategoryDishes> bookedDishes;
  double totalPrice = 0;

  @override
  void initState() {
    bookedDishes =
        widget.dishes!.where((dish) => dish.stepperValue > 0).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(bookedDishes.length);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                'Order Summary',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        )
                      ]),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              color: Colors.green[900],
                              alignment: Alignment.center,
                              child: Text(
                                '${bookedDishes.length} Dishes - ${widget.items} Items',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            Column(
                              children:
                                  List.generate(bookedDishes.length, (index) {
                                totalPrice = totalPrice +
                                    (bookedDishes[index].dishPrice! *
                                        bookedDishes[index]
                                            .stepperValue
                                            .toDouble());
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, left: 5.0),
                                        child: Icon(
                                          Icons.circle,
                                          color: bookedDishes[index]
                                                      .dishAvailability ==
                                                  true
                                              ? Colors.green
                                              : Colors.red,
                                          size: 20.0,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 200.0,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0,
                                                          top: 15.0,
                                                          right: 0.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    bookedDishes[index]
                                                        .dishName!,
                                                    maxLines: 3,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 25.0,
                                                    top: 5.0,
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'INR ${bookedDishes[index].dishPrice!}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 25.0,
                                                      top: 5.0,
                                                    ),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '${bookedDishes[index].dishCalories!} calories',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topCenter,
                                            padding: const EdgeInsets.only(
                                                top: 30.0),
                                            child: Container(
                                              width: 100.0,
                                              height: 30.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.green[900],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              40.0))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        const BoxConstraints(),
                                                    splashColor: Colors.blue,
                                                    autofocus: true,
                                                    visualDensity: VisualDensity
                                                        .adaptivePlatformDensity,
                                                    onPressed: () {
                                                      setState(() {
                                                        if (bookedDishes[index]
                                                                    .stepperValue >
                                                                0 &&
                                                            bookedDishes[index]
                                                                    .stepperValue !=
                                                                0) {
                                                          bookedDishes[index]
                                                              .stepperValue--;
                                                          totalPrice = 0;
                                                        } else {
                                                          bookedDishes[index]
                                                              .stepperValue = 0;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    '${bookedDishes[index].stepperValue}',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (bookedDishes[index]
                                                                .stepperValue >=
                                                            0) {
                                                          bookedDishes[index]
                                                              .stepperValue++;
                                                          totalPrice = 0;
                                                        } else {
                                                          bookedDishes[index]
                                                              .stepperValue = 0;
                                                        }
                                                      });
                                                    },
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        const BoxConstraints(),
                                                    splashColor: Colors.blue,
                                                    autofocus: true,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'INR ${bookedDishes[index].dishPrice! * bookedDishes[index].stepperValue.toDouble()}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: const Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: TextStyle(
                                        color: Colors.green[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  Text(
                                    'INR ${totalPrice.round()}',
                                    style: const TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 20.0),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(top: 50.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => UserHomeBloc(),
                                  child: UserHomePage(widget.user),
                                ),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: const Text(
                            'Place Order',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}
