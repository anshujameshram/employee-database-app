import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> jumpToPage(BuildContext context, Widget page) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (BuildContext context) => page),
  );
}
