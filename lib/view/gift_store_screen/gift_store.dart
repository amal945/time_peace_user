import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_peace_project/model/productmodel.dart';

class GiftStore extends StatefulWidget {
  const GiftStore({super.key});

  @override
  State<GiftStore> createState() => _GiftStoreState();
}

class _GiftStoreState extends State<GiftStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Product product = Product.fromMap(
                  document.data() as Map<String, dynamic>, document.id);
              return ListTile(
                title: Text(product.productName),
                subtitle: Text(
                    'Brand: ${product.brand} | Category: ${product.category}'),
                onTap: () {},
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
