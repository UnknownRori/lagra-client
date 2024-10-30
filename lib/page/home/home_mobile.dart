import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lagra_client/components/text_field.dart';
import 'package:lagra_client/env.dart';
import 'package:lagra_client/models/item.dart';
import 'package:lagra_client/providers/http_client.dart';
import 'package:lagra_client/providers/item_providers.dart';
import 'package:lagra_client/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      HttpClient client = context.read<HttpClient>();
      ItemProviders item_providers = context.read<ItemProviders>();
      fetchItem(client, item_providers);
    });
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: BorderTextField(
            controller: _searchController,
            inputDecoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(500)),
              ),
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          ],
          elevation: 4,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("Lagra Flashsale", style: mobile.subtitle2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _items.take(3).map((item) {
                var api = Environment.API_URL;
                var storage = item.img;
                var url = "https://$api/$storage";

                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        CachedNetworkImage(imageUrl: url, scale: 2),
                        Text(item.name),
                        Text(formatter.format(item.price)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
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
