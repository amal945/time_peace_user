import 'package:flutter/material.dart';
class GoogleSignInButton extends StatelessWidget {
  final Function()? onPressed;

  const GoogleSignInButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.67),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Google_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
