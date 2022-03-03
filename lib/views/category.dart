import 'package:flutter/material.dart';
import 'package:kohisong/views/item_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  final Map category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category['category']),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  category['image'],
                  width: 50,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(category['category']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text("Sungsuma farms"),
                  Text("Wa Municipality"),
                  SizedBox(height: 8),
                  Text("GH₵205.00",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("300 pieces"),
                  SizedBox(height: 10),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemDetails()));
                    },
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green),
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
