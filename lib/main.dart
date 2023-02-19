import 'package:flutter/material.dart';
import 'package:flutter_news/provider/news_provider.dart';
import 'package:flutter_news/screens/feeds_screen.dart';
import 'package:flutter_news/utils/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        title: Constants.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const FeedScreen(),
      ),
    );
  }
}
