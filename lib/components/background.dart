import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
    this.circularAvatarImage = "assets/images/avatar.png",
  }) : super(key: key);

  final String topImage, bottomImage, circularAvatarImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(circularAvatarImage),
              ),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
