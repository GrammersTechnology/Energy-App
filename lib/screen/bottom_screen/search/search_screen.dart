import 'package:demo/const/space_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../const/themes/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 233, 233),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SearchContainer(title: "People"),
          ],
        ),
      )),
    );
  }
}

class SearchContainer extends StatelessWidget {
  SearchContainer({super.key, required this.title});

  String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              ListView.builder(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        child: Row(
                      children: [
                        CircleAvatar(radius: 30),
                        hSpaceRegular,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vSpaceSmall,
                            Text("Name kjbjb",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            vSpaceMin,
                            Text("Domain"),
                            vSpaceMin,
                            Text("age"),
                            vSpaceMin,
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white, //background color of button
                                side: BorderSide(
                                    width: 2,
                                    color:
                                        Colors.orange), //border width and color
                                elevation: 2, //elevation of button
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(
                                    15) //content padding inside button
                                ),
                            onPressed: () {
                              //code to execute when this button is pressed.
                            },
                            child: Text("Elevated Button"))
                      ],
                    ));
                  }),
              Divider(thickness: 2),
              Center(
                child: TextButton(
                  child: Text("See All",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
