import 'package:demo/utils/const/space_helper.dart';
import 'package:flutter/material.dart';

class DetailedGraph extends StatelessWidget {
  DetailedGraph(
      {super.key,
      required this.child,
      required this.title,
      required this.iconDetails,
      required this.details,
      required this.onPress});
  Widget child;
  String title;
  String details;
  String iconDetails;
  void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Row(children: [
          IconButton(
              onPressed: onPress, icon: const Icon(Icons.arrow_back_ios)),
          const Text('Tilbake'),
          hSpaceMedium,
          Text(title)
        ]),
        vSpaceLarge,
        Text(details),
        vSpaceLarge,
        Row(
          children: [
            Text(iconDetails),
            const Icon(Icons.question_mark_rounded)
          ],
        ),
        vSpaceLarge,
        child,
        vSpaceLarge,
        ToggleButtons(
            borderColor: Colors.black,
            selectedColor: Colors.black,
            borderRadius: BorderRadius.circular(30),
            isSelected: const [true, true, false],
            children: const [Text("data"), Text("data"), Text("data")])
      ]),
    );
  }
}
