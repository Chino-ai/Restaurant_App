import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/provider/detail_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';


class DetailPage extends StatelessWidget {
  static const routeName = 'ui/detail_page';
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailProvider(apiService: ApiService(), id: id),
      child: Consumer<DetailProvider>(
        builder: (context,state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (state.state == ResultState.hasData) {
              var restaurant = state.result.restaurant;
              return Scaffold(
                appBar: AppBar(
                  title: Text(restaurant.name),
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network("https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}"),
                      const SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("Nama : ${restaurant.name}")
                      ),
                      const SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("Rating : ${restaurant.rating}")
                      ),
                      const SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("Alamat : ${restaurant.address}")
                      ),

                      const SizedBox(height: 10,),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text("Deskripsi :")
                      ),
                      const SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(restaurant.description)
                      ),
                      const SizedBox(height: 10,),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text("Foods : ",
                            style: TextStyle(fontWeight: FontWeight.w700),)
                      ),
                      const SizedBox(height: 10,),
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
                      const SizedBox(height: 10,),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text("Drinks : ",
                              style: TextStyle(fontWeight: FontWeight.w700))
                      ),
                      const SizedBox(height: 10,),
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
            } else if(state.state == ResultState.error){
              return Center(
                child: Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Nama Restaurant atau internet tidak ada"),
                    ],
                  ),
                ),
              );
            }else{
              return const Material(child: Text(''));
            }
          }
        }
      ),
    );
  }
}
