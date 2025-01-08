import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/favorite_screen.dart';
import 'package:recipeapp/provider/favorite_provider.dart';
import 'package:recipeapp/screens/botton_navbars.dart';
import 'package:recipeapp/screens/home.dart';
import 'package:recipeapp/screens/splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: RecipeApp(),
    ),
  );
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    //
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<FavoriteProvider>(context, listen: false).loadFavorites();
    // });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      // routes: {
      //   '/favorites': (context) => FavoriteScreen(),
      // },
    );
  }
}
