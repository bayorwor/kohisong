import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kohisong/resources/product_methods.dart';
import 'package:kohisong/views/item_details.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  final Map category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category['category']),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
          stream: ProductMethods().getAllProductsByCategory(
              category: widget.category['category'].toString().toLowerCase()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final QuerySnapshot<Map<String, dynamic>?>? products =
                snapshot.data;

            if (products?.docs.isEmpty ?? true) {
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(children: [
                    const Image(
                      image: AssetImage('assets/nodata.png'),
                      height: 200,
                      width: 200,
                    ),
                    Text(
                        'No Products Found for ${widget.category['category']}'),
                  ]),
                ),
              );
            }
            return ListView.builder(
              itemCount: products!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        products.docs[index]['image'],
                        width: 50,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(products.docs[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text("Sungsuma farms"),
                        Text(products.docs[index]['location']),
                        const SizedBox(height: 8),
                        Text("GH₵${products.docs[index]['price']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(products.docs[index]['qnty']),
                        const SizedBox(height: 10),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                          item: products.docs[index],
                                        )));
                          },
                          child: Container(
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green),
                            child: const Icon(
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
            );
          }),
    );
  }
}
