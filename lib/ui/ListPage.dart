import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import '../model/data.dart';
import '../model/restaurant.dart';
import 'DetailPage.dart';


class ListPage extends StatelessWidget {
  static const routeName = '/list_page';
  const ListPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text("Restaurant")),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/restaurants.json'),
        builder: (context, snapshot) {
          final List<Restaurants> restaurant = restaurantFromJson(snapshot.data!).restaurants;
          return ListView.builder(
            itemCount: restaurant.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, restaurant[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Restaurants restaurant) {
  return ListTile(
    onTap: (){
      Navigator.pushNamed(context, DetailPage.routeName,
          arguments: restaurant);
    },
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(
      restaurant.pictureId,
      width: 100,
    ),
    title: Text(restaurant.name),
    subtitle: Text(restaurant.city),
  );
}



