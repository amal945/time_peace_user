import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:time_peace_project/model/cart_model.dart';

class CheckoutPage extends StatelessWidget {
  final List<Cart> cartData;

  const CheckoutPage({Key? key, required this.cartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double totalPrice = 0;

    for (var cart in cartData) {
      totalPrice += cart.quantity * cart.price;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.length,
              itemBuilder: (context, index) {
                final product = cartData[index];
                return ListTile(
                  title: Text(product.productName),
                  subtitle: Text(
                      '${product.quantity} x \$${product.price.toStringAsFixed(2)}'),
                  trailing: Text(
                      '\$${(product.quantity * product.price).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionSlider.standard(
                  sliderBehavior: SliderBehavior.stretch,
                  width: size.width / 1.07,
                  height: size.height / 10.8,
                  backgroundColor: Colors.black,
                  toggleColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ),
                  action: (controller) async {
                    controller.loading(); //starts loading animation
                    await Future.delayed(const Duration(seconds: 3));
                    controller.success(); //starts success animation
                    await Future.delayed(const Duration(seconds: 1));
                    controller.reset(); //resets the slider
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text(
                        'Proceed to pay',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
