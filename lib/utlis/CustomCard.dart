import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  LinearGradient gradient;
  Text title;
  Text description;
  Color circleColor;
  Icon icon;

  CustomCard(
      {@required this.gradient,
      @required this.title,
      @required this.description,
      @required this.circleColor,
      @required this.icon});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      width: 130,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(45.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 54, left: 8, right: 8, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: widget.description),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[widget.title],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(color: widget.circleColor, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            top: 25,
            left: 10,
            child: widget.icon,
          )
        ],
      ),
    );
  }
}
