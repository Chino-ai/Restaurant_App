import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurants.dart';

import '../data/model/get_restaurants.dart';
import '../data/model/search_restaurants.dart';


class DetailPage extends StatefulWidget {
  static const routeName = 'ui/detail_page';
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<DetailRestaurant> _restaurant;

  @override
  void initState() {

    super.initState();
    _restaurant = ApiService().GetDetailResto(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _restaurant,
      builder: (context,AsyncSnapshot<DetailRestaurant> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            var restaurant = snapshot.data?.restaurant;
            return Scaffold(
              appBar: AppBar(
                title: Text(restaurant!.name),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.network("https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}"),
                    SizedBox(height: 10,),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Foods : ",
                          style: TextStyle(fontWeight: FontWeight.w700),)
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: restaurant.menus.foods
                            .map(
                              (food) =>
                              Text(
                                food.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 10,),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Drinks : ",
                            style: TextStyle(fontWeight: FontWeight.w700))
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: restaurant.menus.drinks
                            .map(
                              (drinks) =>
                              Text(
                                drinks.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if(snapshot.hasError){
            return Center(
              child: Material(
                child: Text(snapshot.error.toString()),
              ),
            );
          }else{
            return const Material(child: Text(''));
          }
        }
      }
    );
  }
}
