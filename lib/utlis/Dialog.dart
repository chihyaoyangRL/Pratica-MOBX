import 'package:flutter/material.dart';

class Dialogs extends State {
  transitionBuilder(context, a1, a2, widget, Widget child) {
    final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
    return Transform(
      transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
      child: Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                elevation: double.infinity,
                content: Container(
                  height: 100,
                  child: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
