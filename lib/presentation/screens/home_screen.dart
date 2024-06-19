import 'package:flutter/material.dart';
import 'package:x/data/models/trending.dart';
import 'package:x/presentation/screens/postscreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _page = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: (index){
          setState(() {
            _index = index;
          });
        
        },
        children: [
          PostScreen(),
          // TrendingTab(),
          
        ]
      )
    );
  }
}