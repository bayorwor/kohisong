import 'package:flutter/material.dart';
import 'package:kohisong/farms_data.dart';
import 'package:kohisong/shared/recommened_farms.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Catalog",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text("Kohisong farms")
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic),
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.filter_list,
                  size: 40,
                ),
                onPressed: () {},
              )
            ],
          ),
          SizedBox(height: 16),
          const Text(
            "Recommended Farms",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 16),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return RecommendFarms(title: farms[index]["name"]);
                },
                itemCount: farms.length),
          ),
        ]),
      ),
    );
  }
}
