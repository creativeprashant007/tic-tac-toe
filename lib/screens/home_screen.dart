import 'package:flutter/material.dart';
import 'package:tic_tac_toe/model/home_components.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeComponents> homeComp = [
    HomeComponents(
      title: "New Game",
      callback: () {},
    ),
    HomeComponents(
      title: "Statistics",
      callback: () {},
    ),
    HomeComponents(
      title: "Close",
      callback: () {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 2,
        backgroundColor: Colors.orange,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var homeItem = homeComp[index];
            return ListTile(title: Text(homeItem.title!));
          },
          separatorBuilder: (_, __) => const SizedBox(
                height: 10,
              ),
          itemCount: homeComp.length),
    );
  }
}
