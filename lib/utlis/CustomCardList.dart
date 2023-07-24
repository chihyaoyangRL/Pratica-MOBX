import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCardList extends StatefulWidget {
  LinearGradient gradient;
  Text title;
  Color circleColor;
  Icon icon;

  CustomCardList({@required this.gradient, @required this.title, @required this.circleColor, @required this.icon});

  @override
  _CustomCardListState createState() => _CustomCardListState();
}

class _CustomCardListState extends State<CustomCardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[widget.title],
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: widget.circleColor, shape: BoxShape.circle),
            ),
          ),
          Positioned(top: 22, left: 8, child: widget.icon)
        ],
      ),
    );
  }
}
