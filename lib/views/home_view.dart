import 'package:flutter/material.dart';
import 'package:kohisong/data_sourcess/categories.dart';
import 'package:kohisong/farms_data.dart';
import 'package:kohisong/shared/category_card.dart';
import 'package:kohisong/shared/recommened_farms.dart';
import 'package:kohisong/views/category.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
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
            SizedBox(height: 16),
            const Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  for (var i = 0; i < categories.length; i++)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoryScreen(category: categories[i])));
                      },
                      child: CategoryCard(
                        title: categories[i]["category"],
                        image: categories[i]["image"],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
