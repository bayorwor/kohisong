import 'package:flutter/material.dart';
import 'package:kohisong/resources/cart_methods.dart';
import 'package:kohisong/widgets/toastwidget.dart';
import 'package:unicons/unicons.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: CartMethods().getCartList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.data?["cartList"].length == 0) {
            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(children: const [
                  Image(
                    image: AssetImage('assets/nodata.png'),
                    height: 200,
                    width: 200,
                  ),
                  Text(
                      'No Products Found for your cart,\n Please add some products to cart'),
                ]),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final snapshotData = snapshot.data!['cartList'];

          return ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Container(
                    height: 100,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          snapshotData[index]['item_image'],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(snapshotData[index]['item_name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.grey[200],
                      ),
                      Text('GH₵${snapshotData[index]['item_price']}.00'),
                      Divider(
                        color: Colors.grey[200],
                      ),
                      Text(
                        "${snapshotData[index]['item_qnty']} pcs",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(UniconsLine.trash,
                        color: Colors.red[200], size: 40),
                    onPressed: () {
                      CartMethods()
                          .removeFromCart(snapshotData[index])
                          .then((value) {
                        if (value == "success") {
                          showToast("Product Removed from Cart",
                              color: Colors.green);
                        } else {
                          showToast("Something went wrong", color: Colors.red);
                        }
                      });
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: snapshotData.length,
          );
        },
      ),
    );
  }
}
