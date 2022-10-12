import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart'
;
import 'package:restaurant_app/ui/SearchPage.dart';import '../data/model/get_restaurants.dart';

import 'DetailPage.dart';


class ListPage extends StatefulWidget {
  static const routeName = '/list_page';
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<GetRestaurant> _restaurant;


  @override
  void initState() {

    super.initState();
    _restaurant = ApiService().GetListResto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title: const Text("Restaurant"),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, SearchPage.routeName);
                  },
                  icon: const Icon(Icons.search)
              )
            ],
          ),
      body: FutureBuilder(
        future: _restaurant,
        builder: (context, AsyncSnapshot<GetRestaurant> snapshot) {
          var state = snapshot.connectionState;
          if(state != ConnectionState.done){
            return const Center(child: CircularProgressIndicator());
          }else{
            if(snapshot.hasData){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant =  snapshot.data?.restaurants[index];
                  return _buildArticleItem(context, restaurant!);
                },
              );
            }else if (snapshot.hasError){
              return Center(
                child: Material(
                  child: Text(snapshot.error.toString()),
                ),
              );
            }else{
              return const Material(child: Text(''));
            }
          }

        },
      ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, GRestaurant restaurant) {
  return ListTile(
    onTap: (){
      Navigator.pushNamed(context, DetailPage.routeName,
          arguments: restaurant.id);
    },
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(
      "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
      width: 100,
    ),
    title: Text(restaurant.name),
    subtitle: Text(restaurant.city),
  );
}



