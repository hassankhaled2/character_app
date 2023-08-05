import 'package:flutter/material.dart';
import 'package:character_app/app_router.dart';
void main() {
  runApp( RickMortyApp(appRouter: AppRouter(),));
}

class RickMortyApp extends StatelessWidget {
   final AppRouter appRouter;
   const RickMortyApp({Key?key,required this.appRouter}):super(key:key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:appRouter.generateRoute ,
    );
  }
}

