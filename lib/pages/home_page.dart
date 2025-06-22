import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<dynamic> items = [
    {
      "first": "Phone",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0praxNFT7dTQYuQlpiE9nl6gbXzpnY0kSRg&s",
    },
    {
      "first": "Laptop",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVfUrTMlZjzQncknnLg3XoHhlSKsKy7ajVGw&s",
    },
    {
      "first": "Chair",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh0pMQfyxnz4Y2Dtfv2aCfyc8cVLxjewNX8Q&s",
    },
    {
      "first": "Watch",
      "image":
          "https://www.titan.co.in/dw/image/v2/BKDD_PRD/on/demandware.static/-/Sites-titan-master-catalog/default/dw34d84041/images/Titan/Catalog/1698KM02_1.jpg?sw=800&sh=800",
    },
    {
      "first": "Phone",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0praxNFT7dTQYuQlpiE9nl6gbXzpnY0kSRg&s",
    },
    {
      "first": "Laptop",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVfUrTMlZjzQncknnLg3XoHhlSKsKy7ajVGw&s",
    },
    {
      "first": "Chair",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh0pMQfyxnz4Y2Dtfv2aCfyc8cVLxjewNX8Q&s",
    },
    {
      "first": "Watch",
      "image":
          "https://www.titan.co.in/dw/image/v2/BKDD_PRD/on/demandware.static/-/Sites-titan-master-catalog/default/dw34d84041/images/Titan/Catalog/1698KM02_1.jpg?sw=800&sh=800",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vivekanandapally"),
            Text(
              "Kharagpur",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.currency_rupee_sharp)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.mic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text("VEG", style: TextStyle(fontSize: 16)),
                    Text("MODE", style: TextStyle(fontSize: 10)),
                    Icon(Icons.power_off_outlined),
                  ],
                ),
              ],
            ),
            Image.network(
              "https://www.shutterstock.com/image-photo/shopping-online-ordering-product-using-260nw-2150537657.jpg",
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => Column(
                      spacing: 5,
                      children: [
                        Image.network(items[index]["image"], height: 65),
                        Text(items[index]["first"]),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.home)),
          IconButton(onPressed: () {}, icon: Icon(Icons.home)),
          IconButton(onPressed: () {}, icon: Icon(Icons.home)),
          IconButton(onPressed: () {}, icon: Icon(Icons.home)),
        ],
      ),
    );
  }
}
