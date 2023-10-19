import 'package:demo/utils/const/space_helper.dart';
import 'package:flutter/material.dart';

class DetailedGraph extends StatelessWidget {
  DetailedGraph(
      {super.key,
      required this.child,
      required this.title,
      required this.IconDetails,
      required this.details,
      required this.onPress});
  Widget child;
  String title;
  String details;
  String IconDetails;
  void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Row(children: [
          IconButton(onPressed: onPress, icon: Icon(Icons.arrow_back_ios)),
          Text('Tilbake'),
          hSpaceMedium,
          Text(title)
        ]),
        vSpaceLarge,
        Text(details),
        vSpaceLarge,
        Row(
          children: [Text(IconDetails), Icon(Icons.question_mark_rounded)],
        ),
        vSpaceLarge,
        child,
        vSpaceLarge,
        ToggleButtons(
            borderColor: Colors.black,
            selectedColor: Colors.black,
            borderRadius: BorderRadius.circular(30),
            children: [Text("data"), Text("data"), Text("data")],
            isSelected: [true, true, false])
      ]),
    );
  }
}
