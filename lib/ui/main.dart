import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import '../data/provider/list_provider.dart';
import 'DetailPage.dart';
import 'ListPage.dart';
import 'SearchPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider(apiService: ApiService())),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.blueGrey,
                  onPrimary: Colors.white,
                  secondary: Colors.lightBlue,
                )),
        initialRoute: ListPage.routeName ,
        routes: {
          ListPage.routeName: (context) => const ListPage(),
          DetailPage.routeName: (context) => DetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String
          ),
          SearchPage.routeName: (context) => SearchPage()
        }
      ),
    );
  }
}
