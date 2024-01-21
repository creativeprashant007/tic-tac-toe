import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tic_tac_toe/model/home_components.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeComponents> homeComp = [
    HomeComponents(
      title: "Single Player",
      callback: () {
        // Navigator.pushNamed(context, '/tic_tac_toe_screen');
      },
    ),
    HomeComponents(
      title: "Multi Players",
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
            return ListTile(
                title: Text(homeItem.title!),
                onTap: () {
                  if (index == 0) {
                    Navigator.of(context).pushNamed('tic_tac_toe_screen');
                  } else if (index == 1) {
                    Navigator.of(context).pushNamed("single_player");
                  } else {
                    Fluttertoast.showToast(
                        msg: "Back 2 more time to close the app",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                });
          },
          separatorBuilder: (_, __) => const SizedBox(
                height: 10,
              ),
          itemCount: homeComp.length),
    );
  }
}
