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
          spacing: 12,
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
            Row(
              spacing: 10,
              children: [
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.filter), Text("Filters")],
                  ),
                ),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.filter), Text("Filters")],
                  ),
                ),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.filter), Text("Filters")],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("EXPLORE MORE", style: TextStyle(color: Colors.grey)),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Container(
                  width: 75,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://img.freepik.com/premium-vector/special-offer-banner-red-yellow-flag-shape_78946-860.jpg?semt=ais_hybrid&w=740",
                        height: 50,
                      ),
                      Text("Offers"),
                    ],
                  ),
                ),
                Container(
                  width: 75,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://img.freepik.com/free-vector/3d-metal-star-isolated_1308-117760.jpg?semt=ais_hybrid&w=740",
                        height: 50,
                      ),
                      Text("Top 10"),
                    ],
                  ),
                ),
                Container(
                  width: 75,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://img.freepik.com/premium-vector/realistic-train-vector-illustration-concept_1253202-29241.jpg?semt=ais_hybrid&w=740",
                        height: 30,
                      ),
                      Text("Food"),
                      Text("on train"),
                    ],
                  ),
                ),
                Container(
                  width: 75,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://www.shutterstock.com/image-vector/berger-character-logo-street-food-600nw-2622309653.jpg",
                        height: 50,
                      ),
                      Text("Collections", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: Row(
              spacing: 5,
              children: [Icon(Icons.delivery_dining), Text("Delivery")],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Row(children: [Icon(Icons.dinner_dining), Text("Dining")]),
          ),
          IconButton(
            onPressed: () {},
            icon: Row(children: [Text("district"), Icon(Icons.arrow_forward)]),
          ),
        ],
      ),
    );
  }
}
