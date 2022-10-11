import 'package:flutter/material.dart';

import '../model/restaurant.dart';



class DetailPage extends StatelessWidget {
  static const routeName = 'ui/detail_page';
  final Restaurants restaurant;
  const DetailPage({Key? key,required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(restaurant.pictureId),
            SizedBox(height: 10,),
            const Align(
                alignment: Alignment.topLeft,
                child: Text("Foods : ",style: TextStyle(fontWeight: FontWeight.w700),)
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: restaurant.menus.foods
                    .map(
                      (food) => Text(
                    food.name,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ).toList(),
              ),
            ),
            SizedBox(height: 10,),
            const Align(
                alignment: Alignment.topLeft,
                child: Text("Drinks : ",style: TextStyle(fontWeight: FontWeight.w700))
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: restaurant.menus.drinks
                    .map(
                      (drinks) => Text(
                    drinks.name,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );;
  }
}
