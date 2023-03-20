import 'package:flutter/material.dart';

Widget postCard(BuildContext context,
    {required String title, required String desc}) {
  return Container(
    decoration: BoxDecoration(color: Colors.blue.withOpacity(0.5)),
    width: double.infinity,
    height: MediaQuery.of(context).size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), Text(desc)],
    ),
  );
}
