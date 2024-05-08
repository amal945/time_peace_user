import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import '../../model/productmodel.dart';

class GlobalCheckoutPage extends StatefulWidget {
  final Product product;

  const GlobalCheckoutPage({Key? key, required this.product}) : super(key: key);

  @override
  State<GlobalCheckoutPage> createState() => _GlobalCheckoutPageState();
}

class _GlobalCheckoutPageState extends State<GlobalCheckoutPage> {
  late double totalPrice;
  int quantity = 1;
  int deliveryCharge = 100;

  @override
  void initState() {
    totalPrice = widget.product.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          Expanded(child: SizedBox()),
          ListTile(
            title: Text(widget.product.productName),
            subtitle: Text(
                ' ${quantity} x \$${widget.product.price.toStringAsFixed(2)}'),
            trailing: Text(
                ' \$${(quantity * widget.product.price).toStringAsFixed(2)}'),
          ),
          ListTile(
            title: Text("Delivery charge "),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 25,
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
