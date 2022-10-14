import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/provider/list_provider.dart';
import 'package:restaurant_app/ui/SearchPage.dart';
import 'package:restaurant_app/utils/result_state.dart';
import '../data/model/get_restaurants.dart';
import 'DetailPage.dart';


class ListPage extends StatelessWidget {
  static const routeName = '/list_page';
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return RefreshIndicator(
          onRefresh: (){return context.read<ListProvider>().fetchAllArticle();},
          child: Scaffold(
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
            body: ListView(
              children: [Consumer<ListProvider>(
                builder: (context, state, _) {
                  if(state.state == ResultState.loading){
                    return const Center(child: CircularProgressIndicator());
                  }else{
                    if(state.state == ResultState.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: state.result?.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant =  state.result?.restaurants[index];
                          return _buildArticleItem(context, restaurant!);
                        },
                      );
                    }else if (state.state == ResultState.noData){
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
                    }else if(state.state == ResultState.error){
                      return Material(child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Nama Restaurant atau internet tidak ada"),
                            SizedBox(height: 10,),
                            Text('Lakukan Swipe untuk Refresh'),
                          ],
                        ),
                      ));
                    }else{
                      return const Material(child: Text(''));
                    }
                  }
                },
              ),
          ]
            ),
          ),
        );
      }
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



