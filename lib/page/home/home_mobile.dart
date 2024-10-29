import 'package:flutter/material.dart';
import 'package:lagra_client/components/text_field.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/item_providers.dart';
import 'package:provider/provider.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  int _currentIndex = 0;
  TextEditingController _searchController = TextEditingController();
  List<Item> _items = [];

  void fetchItem(HttpClient client, ItemProviders provider) async {
    var item = await provider.fetch(client);
    setState(() {
      _items = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    HttpClient client = context.read<HttpClient>();
    ItemProviders item_providers = context.read<ItemProviders>();
    fetchItem(client, item_providers);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: BorderTextField(
            controller: _searchController,
            inputDecoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(500)),
              ),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          ],
          elevation: 4,
        ),
      ),
      body: SafeArea(
        child: const Text("Yo"),
      ),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
