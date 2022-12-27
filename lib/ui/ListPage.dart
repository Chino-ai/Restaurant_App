import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/provider/list_provider.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import '../data/provider/database_provider.dart';
import '../utils/notification_helper.dart';
import 'detail_page.dart';
import 'favourite_page.dart';


class ListPage extends StatefulWidget {
  static const routeName = '/list_page';
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}
class _ListPageState extends State<ListPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();


  @override
  void initState() {
    _notificationHelper.configureSelectNotificationSubject(
        ListPage.routeName);
    super.initState();
  }
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
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
                          Navigator.pushNamed(context, FavouritePage.routeName);
                        },
                        icon: const Icon(Icons.favorite)
                    ),

                    IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, SettingPage.routeName);
                        },
                        icon: const Icon(Icons.settings)
                    ),
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

Widget _buildArticleItem(BuildContext context, Restaurant restaurant) {
  return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavourite(restaurant.id),
            builder: (context, snapshot) {
              var isFavourited = snapshot.data ?? false;
              return ListTile(
                trailing: isFavourited ?
                IconButton(
                  onPressed: () => provider.removeFavourite(restaurant.id),
                  icon: const Icon(Icons.favorite),
                  color: Theme.of(context).colorScheme.secondary,
                ) :
                IconButton(
                  onPressed: () => provider.addFavourite(restaurant),
                  icon: const Icon(Icons.favorite_border),
                  color: Theme.of(context).colorScheme.secondary,
                ),

                onTap: () {
                  Navigator.pushNamed(context, DetailPage.routeName,
                      arguments: restaurant.id);
                },
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${restaurant
                      .pictureId}",
                  width: 100,
                ),
                title: Text(restaurant.name),
                subtitle: Text(restaurant.city),
              );

            }
        );

      }
  );
}


