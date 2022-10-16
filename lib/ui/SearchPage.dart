
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search_restaurants.dart';
import 'package:restaurant_app/data/provider/search_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';

import 'DetailPage.dart';


class SearchPage extends StatelessWidget {
  static const routeName = '/search_page';
  SearchPage({Key? key}) : super(key: key);

    late String query;

   TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SearchProvider(apiService: ApiService()),
            child:  Builder(
              builder: (context) {
                return RefreshIndicator(
                  onRefresh: (){return context.read<SearchProvider>().fetchAllArticle(controller.text);},
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text("Search Restaurant"),
                    ),
                    body: ListView(
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: TextField(
                              onSubmitted: (String value) {
                                  context.read<SearchProvider>().fetchAllArticle(controller.text);
                              },
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: 'Tuliskan Nama Restoran...',
                                labelText: 'Cari Restoran',
                              ),
                            ),
                          ),
                          Text(controller.text),
                          Consumer<SearchProvider>(
                              builder: (context, state, _) {
                                if (state.state == ResultState.loading) {
                                  return const Center(child: CircularProgressIndicator());
                                } else {
                                  if (state.state == ResultState.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: state.result?.restaurants.length,
                                      itemBuilder: (context, index) {
                                        var restaurant = state.result?.restaurants[index];
                                        return _buildArticleItem(context, restaurant!);
                                      },
                                    );
                                  } else if (state.state == ResultState.error) {
                                    return Center(
                                      child: Material(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text("Nama Restaurant atau internet tidak ada"),
                                            SizedBox(height: 10,),
                                            Text('Lakukan Swipe untuk Refresh'),

                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Material(child: Text(''));
                                  }
                                }
                              }
                          ),

                        ]
                    ),
                  ),
                );
              }
            )
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



