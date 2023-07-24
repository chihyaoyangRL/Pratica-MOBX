import 'package:flutter/material.dart';

class Lifecycle extends State {
  void addListner(dynamic pagelocal) {
    WidgetsBinding.instance.addObserver(pagelocal);
  }

  void removerListner(dynamic pagelocal) {
    WidgetsBinding.instance.removeObserver(pagelocal);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
