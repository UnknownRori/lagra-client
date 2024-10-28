import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Login"),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        elevation: 4,
        //clipBehavior: Clip.antiAlias,
        child: SafeArea(
            child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell),
              label: "Produk Baru",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Wishlist",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        )),
      ),
    );
  }
}
