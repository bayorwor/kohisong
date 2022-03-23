import 'package:flutter/material.dart';
import 'package:kohisong/resources/cart_methods.dart';
import 'package:kohisong/views/add_to_cart.dart';
import 'package:kohisong/widgets/toastwidget.dart';
import 'package:unicons/unicons.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails({Key? key, required this.item}) : super(key: key);

  final item;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final TextEditingController _qntyController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  sendToCart() {
    setState(() {
      _isLoading = true;
    });
    dynamic itemData = {
      'item_id': widget.item['uid'],
      'item_name': widget.item['name'],
      'item_price': widget.item['price'],
      'item_image': widget.item['image'],
      'item_qnty': _qntyController.text,
    };
    print(itemData);
    CartMethods().addToCart(itemData).then((value) {
      if (value == "success") {
        Navigator.pop(context);
        showToast("Item added to cart", color: Colors.green);
        setState(() {
          _isLoading = false;
        });
      } else {
        Navigator.pop(context);
        showToast(value);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          actions: [
            TextButton.icon(
              icon: Icon(Icons.shopping_cart),
              label: Text('ADD'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Please select quantity"),
                        content: Form(
                          key: _formKey,
                          child: Container(
                            height: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _qntyController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter quantity';
                                      } else if (int.parse(value) >
                                          int.parse(widget.item['qnty'])) {
                                        return 'Quantity is not available';
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Quantity',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.red,
                            ),
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text("Save"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                sendToCart();
                              }
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.item['image']), //NetworkImage(item['image']),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item['name'],
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "GH₵${widget.item['price']}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hamdala Farms",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                ),
                Text(
                  "Tumu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.item["qnty"]} pcs",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w100),
                ),
                Text(
                  "233 505 429 444",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.item['description'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/maps.jpg",
                      ),
                      fit: BoxFit.cover)),
            ),
          ]),
        ));
  }
}
