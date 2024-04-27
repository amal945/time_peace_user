// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:time_peace_project/model/productmodel.dart';

class ProductDetailsPage extends StatelessWidget {
  Product data;

  ProductDetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: const [],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Buy Now'),
        icon: const Icon(Icons.shopping_cart),
      ),
      body: ListView(
        children: [
          // Product image
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.network(
              data.image,
              height: MediaQuery.of(context).size.height / 2,
              fit: BoxFit.fill,
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment(0.9, 0),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 30,
                ),
              )
            ],
          ),
          // Product title
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Text(
                  data.productName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
            ],
          ),

          // Product description
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Text(data.description),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              'Color:${data.color.toUpperCase()}',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          // Product color

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Price: ${data.price.toString()}",
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
