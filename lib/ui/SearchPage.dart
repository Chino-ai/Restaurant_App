import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search_restaurants.dart';

import 'DetailPage.dart';


class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<SearchRestaurant> _restaurant;


  @override
  void initState() {

    super.initState();
    _restaurant = ApiService().GetSearchResto("Makan mudah");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title: Text("Search Restaurant"),

          ),
      body: ListView(
        children:[
      Padding(
      padding:EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Write your name here...',
            labelText: 'Your Name',
          ),
          onChanged: (String value) {
            setState(() {
              _restaurant = ApiService().GetSearchResto(value);
            });
          },
        ),
      ),
          FutureBuilder(
            future: _restaurant,
            builder: (context, AsyncSnapshot<SearchRestaurant> snapshot) {
              var state = snapshot.connectionState;
              if(state != ConnectionState.done){
                return const Center(child: CircularProgressIndicator());
              }else{
                if(snapshot.hasData){
                  return ListView.builder(
                        shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data?.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant =  snapshot.data?.restaurants[index];
                          return _buildArticleItem(context, restaurant!);
                        },
                  );

                }else if (snapshot.hasError){
                  return Center(
                    child: Material(
                      child: Text("Nama Restaurant atau internet tidak ada"),
                    ),
                  );
                }else{
                  return const Material(child: Text(''));
                }
              }

            },

          ),
      ]
      ),

    );
    
  }
}

Widget _buildArticleItem(BuildContext context, SRestaurant restaurant) {
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



