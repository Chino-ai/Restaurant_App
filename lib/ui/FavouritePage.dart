import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/get_restaurants.dart';
import '../data/provider/database_provider.dart';
import '../utils/result_state.dart';
import 'DetailPage.dart';

class FavouritePage extends StatelessWidget {
  static const routeName = '/favourite_page';
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite'),),
      body: _buildList()
    );
  }
}


Widget _buildList() {
  return Consumer<DatabaseProvider>(
    builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: provider.favourites.length,
          itemBuilder: (context, index) {
            return _buildArticleItem(context, provider.favourites[index]);
          },
        );
      } else {
        return Center(
          child: Material(
            child: Text(provider.message),
          ),
        );
      }
    },
  );
}


Widget _buildArticleItem(BuildContext context, GRestaurant restaurant) {
  return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavourite(restaurant.id),
            builder: (context, snapshot) {
              var isFavourited = snapshot.data ?? false;
              return Material(
                child: ListTile(
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
                ),
              );

            }
        );

      }
  );
}