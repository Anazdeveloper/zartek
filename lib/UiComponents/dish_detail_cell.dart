import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zartek/Modals/restaurant_modal.dart';

class DishDetailCell extends StatelessWidget {

  final String ? dishName;
  final String ? dishImage;
  final double ? dishPrice;
  final double ? dishCalories;
  final String ? dishDescription;
  final List<AddonCat> ? addonCat;
  final bool ? dishAvailbility;

  DishDetailCell({this.dishName,this.dishImage,this.dishPrice,this.dishCalories,this.dishDescription, this.addonCat, this.dishAvailbility});

  @override
  Widget build(BuildContext context) {
    int stepperValue = 0;
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
              color: dishAvailbility == true ? Colors.green : Colors.red,
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
                    dishName!,
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
                        'INR $dishPrice',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0
                        ),
                      ),
                      const SizedBox(width: 120.0,),
                      Text(
                        '$dishCalories calories',
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
                    dishDescription!,
                    maxLines: 3,
                    style: const TextStyle(
                        color: Colors.grey,
                        //fontWeight: FontWeight.bold,
                        //fontSize: 18.0
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                  child: Container(
                    width: 100.0,
                    height: 30.0,
                    decoration: BoxDecoration(
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
                          //icon: SvgPicture.asset("assets/images/circle-minus.svg"),
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          splashColor: Colors.blue,
                          autofocus: true,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          onPressed: () async {
                            stepperValue --;
                          },
                        ),
                        Text(
                              '$stepperValue',
                          //"${snapshot.data!.elementAt(index).additionalPets}",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        IconButton(
                          //icon: SvgPicture.asset("assets/images/circle-plus.svg"),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: (){
                            //stepperValue ++;

                          },
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
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
                  child: addonCat!.isNotEmpty ? const Text(
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
  }
}