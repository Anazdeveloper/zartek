import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/Screens/CheckoutScreen/checkout_page.dart';
import 'package:zartek/Screens/User%20Home/user_home_bloc.dart';
import 'package:zartek/UiComponents/dish_detail_cell.dart';
import 'package:zartek/UiComponents/progress.dart';

class UserHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserHomePageState();
  }
}

class UserHomePageState extends State<UserHomePage> {
  int counter = 0;
  bool isEnabled = false;
  bool toCart = false;
  //List<String> ? dishNames;

  @override
  Widget build(BuildContext context) {

    final blocprovider = BlocProvider.of<UserHomeBloc>(context);
    if(!isEnabled) blocprovider.add(UserHomeUiLoadedEvent());
    return SafeArea(
        child: BlocBuilder(
          bloc: blocprovider,
          builder: (context, state) {
            if(state is UserHomeUiLoadedState) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 5.0,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                      color: Colors.grey[700],
                      size: 30.0,
                    ),
                  ),
                  actions: [
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              // for(var i = 0; i <= state.categoryDishes!.length; i++) {
                              //   if(state.categoryDishes![i].stepperValue > 0) {
                              //     dishNames!.add(state.categoryDishes![i].dishName!);
                              //   }
                              // }
                              //print(dishNames!.length);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(state.categoryDishes,counter)));
                              // setState(() {
                              //   toCart = true;
                              // });
                            },
                            // ignore: unnecessary_new
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.grey[700],
                              size: 30.0,
                            )),
                        counter > 0
                            ? Positioned(
                            right: 11,
                            top: 11,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minHeight: 14,
                                minWidth: 14,
                              ),
                              child: Text(
                                '$counter',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ))
                            : Positioned(
                            right: 11,
                            top: 11,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minHeight: 14,
                                minWidth: 14,
                              ),
                              child: const Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: List.generate(state.categoryDishes!.length, (index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:15.0,left: 5.0),
                              child: Icon(
                                Icons.circle,
                                color: state.categoryDishes![index].dishAvailability == true ? Colors.green : Colors.red,
                                size: 20.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0,left: 340.0),
                              child: Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                    )
                                ),
                                child: Image.asset(
                                  'assets/images/firebase.webp',
                                  fit: BoxFit.fill,
                                  width: 80.0,
                                  height: 80.0,
                                ),
                              ),
                            ),
                            Container(
                              //width: MediaQuery.of(context).size.width * 0.80,
                              width: 340.0,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 25.0,top: 15.0,right: 0.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.categoryDishes![index].dishName!,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 25.0,top: 5.0,),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          'INR ${state.categoryDishes![index].dishPrice!}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0
                                          ),
                                        ),
                                        const SizedBox(width: 120.0,),
                                        Text(
                                          '${state.categoryDishes![index].dishCalories!} calories',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 25.0,top: 5.0,right: 0.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.categoryDishes![index].dishDescription!,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                                    child: Container(
                                      width: 100.0,
                                      height: 30.0,
                                      decoration: const BoxDecoration(
                                          color: Colors
                                              .green,
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(40.0))),
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
                                            constraints: const BoxConstraints(),
                                            splashColor: Colors.blue,
                                            autofocus: true,
                                            visualDensity: VisualDensity.adaptivePlatformDensity,
                                            onPressed: () {
                                              setState(() {
                                                if(state.categoryDishes![index].stepperValue > 0 && state.categoryDishes![index].stepperValue != 0) {
                                                  state.categoryDishes![index].stepperValue --;
                                                  counter --;
                                                } else if (counter == 0 ) {
                                                  state.categoryDishes![index].stepperValue = 0;
                                                  counter = 0;
                                                }
                                                isEnabled = true;
                                              });
                                            },
                                          ),
                                          Text(
                                            //state.categoryDishes![index].stepperValue > 0 ?'${state.categoryDishes![index].stepperValue}' : '0',
                                            '${state.categoryDishes![index].stepperValue}',
                                            style: const TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                if(state.categoryDishes![index].stepperValue >= 0 ) {
                                                  state.categoryDishes![index].stepperValue ++;
                                                  counter ++;
                                                } else {
                                                  state.categoryDishes![index].stepperValue = 0;
                                                  counter = 0;
                                                }
                                                isEnabled = true;
                                              });

                                            },
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            splashColor: Colors.blue,
                                            autofocus: true,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                                    alignment: Alignment.bottomLeft,
                                    child: state.categoryDishes![index].addonCat!.isNotEmpty ? const Text(
                                      'Customizations Available',
                                      style: TextStyle(
                                          color: Colors.red
                                      ),
                                    ) : Container(),
                                  )
                                ],
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.topRight,
                            //   child: dishImage != null ? Image.network(
                            //     dishImage!,
                            //     width: 30.0,
                            //     height: 30.0,
                            //   ) : Container(
                            //     width: 30.0,
                            //       height: 30.0,
                            //     alignment: Alignment.center,
                            //     color: Colors.black,
                            //     child: Text(
                            //       'No image',
                            //       style: TextStyle(
                            //         color: Colors.white
                            //       ),
                            //     ),
                            //   )
                            // ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: const Divider(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                      // return DishDetailCell(
                      //   dishName: state.categoryDishes![index].dishName,
                      //   dishImage: state.categoryDishes![index].dishImage,
                      //   dishPrice: state.categoryDishes![index].dishPrice,
                      //   dishCalories: state.categoryDishes![index].dishCalories,
                      //   dishDescription:
                      //       state.categoryDishes![index].dishDescription,
                      //   addonCat: state.categoryDishes![index].addonCat,
                      //   dishAvailbility:
                      //       state.categoryDishes![index].dishAvailability,
                      // );
                    }),
                  ),
                ),
                // body: BlocBuilder(
                //   bloc: blocprovider,
                //   builder: (context, state) {
                //     if (state is UserHomeUiLoadedState) {
                //       //stepperValue.length = state.categoryDishes!.length;
                //       return SingleChildScrollView(
                //         child: Column(
                //           children: List.generate(state.categoryDishes!.length, (index) {
                //             return Container(
                //               height: MediaQuery.of(context).size.height * 0.25,
                //               width: MediaQuery.of(context).size.width,
                //               decoration: const BoxDecoration(
                //                 color: Colors.white,
                //               ),
                //               child: Stack(
                //                 alignment: Alignment.topLeft,
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(top:15.0,left: 5.0),
                //                     child: Icon(
                //                       Icons.circle,
                //                       color: state.categoryDishes![index].dishAvailability == true ? Colors.green : Colors.red,
                //                       size: 20.0,
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(top: 20.0,left: 340.0),
                //                     child: Container(
                //                       width: 80.0,
                //                       height: 80.0,
                //                       decoration: BoxDecoration(
                //                           border: Border.all(
                //                             width: 1,
                //                           )
                //                       ),
                //                       child: Image.asset(
                //                         'assets/images/firebase.webp',
                //                         fit: BoxFit.fill,
                //                         width: 80.0,
                //                         height: 80.0,
                //                       ),
                //                     ),
                //                   ),
                //                   Container(
                //                     //width: MediaQuery.of(context).size.width * 0.80,
                //                     width: 340.0,
                //                     child: Column(
                //                       children: [
                //                         Container(
                //                           padding: const EdgeInsets.only(left: 25.0,top: 15.0,right: 0.0),
                //                           alignment: Alignment.centerLeft,
                //                           child: Text(
                //                             state.categoryDishes![index].dishName!,
                //                             maxLines: 3,
                //                             style: const TextStyle(
                //                                 color: Colors.black,
                //                                 fontWeight: FontWeight.bold,
                //                                 fontSize: 20.0
                //                             ),
                //                           ),
                //                         ),
                //                         Container(
                //                           padding: const EdgeInsets.only(left: 25.0,top: 5.0,),
                //                           alignment: Alignment.centerLeft,
                //                           child: Row(
                //                             children: [
                //                               Text(
                //                                 'INR ${state.categoryDishes![index].dishPrice!}',
                //                                 style: const TextStyle(
                //                                     color: Colors.black,
                //                                     fontSize: 18.0
                //                                 ),
                //                               ),
                //                               const SizedBox(width: 120.0,),
                //                               Text(
                //                                 '${state.categoryDishes![index].dishCalories!} calories',
                //                                 style: const TextStyle(
                //                                     color: Colors.black,
                //                                     fontSize: 18.0
                //                                 ),
                //                               )
                //                             ],
                //                           ),
                //                         ),
                //                         Container(
                //                           padding: const EdgeInsets.only(left: 25.0,top: 5.0,right: 0.0),
                //                           alignment: Alignment.centerLeft,
                //                           child: Text(
                //                             state.categoryDishes![index].dishDescription!,
                //                             maxLines: 3,
                //                             style: const TextStyle(
                //                               color: Colors.grey,
                //                             ),
                //                           ),
                //                         ),
                //                         Container(
                //                           alignment: Alignment.centerLeft,
                //                           padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                //                           child: Container(
                //                             width: 100.0,
                //                             height: 30.0,
                //                             decoration: const BoxDecoration(
                //                                 color: Colors
                //                                     .green,
                //                                 borderRadius:
                //                                 BorderRadius.all(
                //                                     Radius.circular(40.0))),
                //                             child: Row(
                //                               mainAxisAlignment:
                //                               MainAxisAlignment
                //                                   .spaceBetween,
                //                               children: [
                //                                 IconButton(
                //                                   icon: const Icon(
                //                                     Icons.remove,
                //                                     color: Colors.white,
                //                                   ),
                //                                   padding: EdgeInsets.zero,
                //                                   constraints: const BoxConstraints(),
                //                                   splashColor: Colors.blue,
                //                                   autofocus: true,
                //                                   visualDensity: VisualDensity.adaptivePlatformDensity,
                //                                   onPressed: () {
                //                                     setState(() {
                //                                       if(state.categoryDishes![index].stepperValue > 0 && state.categoryDishes![index].stepperValue != 0) {
                //                                         state.categoryDishes![index].stepperValue --;
                //                                         counter --;
                //                                       } else if (counter == 0 ) {
                //                                         state.categoryDishes![index].stepperValue = 0;
                //                                         counter = 0;
                //                                       }
                //                                       isEnabled = true;
                //                                     });
                //                                   },
                //                                 ),
                //                                 Text(
                //                                   //state.categoryDishes![index].stepperValue > 0 ?'${state.categoryDishes![index].stepperValue}' : '0',
                //                                   '${state.categoryDishes![index].stepperValue}',
                //                                   style: const TextStyle(
                //                                       color: Colors.white
                //                                   ),
                //                                 ),
                //                                 IconButton(
                //                                   icon: const Icon(
                //                                     Icons.add,
                //                                     color: Colors.white,
                //                                   ),
                //                                   onPressed: (){
                //                                     setState(() {
                //                                       if(state.categoryDishes![index].stepperValue >= 0 ) {
                //                                         state.categoryDishes![index].stepperValue ++;
                //                                         counter ++;
                //                                       } else {
                //                                         state.categoryDishes![index].stepperValue = 0;
                //                                         counter = 0;
                //                                       }
                //                                       isEnabled = true;
                //                                     });
                //
                //                                   },
                //                                   padding: EdgeInsets.zero,
                //                                   constraints: const BoxConstraints(),
                //                                   splashColor: Colors.blue,
                //                                   autofocus: true,
                //                                 )
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                         Container(
                //                           padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                //                           alignment: Alignment.bottomLeft,
                //                           child: state.categoryDishes![index].addonCat!.isNotEmpty ? const Text(
                //                             'Customizations Available',
                //                             style: TextStyle(
                //                                 color: Colors.red
                //                             ),
                //                           ) : Container(),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                   // Container(
                //                   //   alignment: Alignment.topRight,
                //                   //   child: dishImage != null ? Image.network(
                //                   //     dishImage!,
                //                   //     width: 30.0,
                //                   //     height: 30.0,
                //                   //   ) : Container(
                //                   //     width: 30.0,
                //                   //       height: 30.0,
                //                   //     alignment: Alignment.center,
                //                   //     color: Colors.black,
                //                   //     child: Text(
                //                   //       'No image',
                //                   //       style: TextStyle(
                //                   //         color: Colors.white
                //                   //       ),
                //                   //     ),
                //                   //   )
                //                   // ),
                //                   Container(
                //                     alignment: Alignment.bottomCenter,
                //                     child: const Divider(
                //                       color: Colors.black,
                //                     ),
                //                   )
                //                 ],
                //               ),
                //             );
                //             // return DishDetailCell(
                //             //   dishName: state.categoryDishes![index].dishName,
                //             //   dishImage: state.categoryDishes![index].dishImage,
                //             //   dishPrice: state.categoryDishes![index].dishPrice,
                //             //   dishCalories: state.categoryDishes![index].dishCalories,
                //             //   dishDescription:
                //             //       state.categoryDishes![index].dishDescription,
                //             //   addonCat: state.categoryDishes![index].addonCat,
                //             //   dishAvailbility:
                //             //       state.categoryDishes![index].dishAvailability,
                //             // );
                //           }),
                //         ),
                //       );
                //     }
                //     return Progress();
                //   },
                // ),
              );
            }
            return Progress();
          },
        ));
  }
}
