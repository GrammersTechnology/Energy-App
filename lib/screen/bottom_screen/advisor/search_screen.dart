import 'package:demo/const/space_helper.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
  const SearchContainer({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              ListView.builder(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        child: Row(
                      children: [
                        const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png')),
                        hSpaceRegular,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vSpaceSmall,
                            Text("User ${index + 1} ",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            vSpaceMin,
                            const Text("Domain"),
                            vSpaceMin,
                            const Text("age"),
                            vSpaceMin,
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 35,
                            ))
                      ],
                    ));
                  }),
              const Divider(thickness: 2),
              Center(
                child: TextButton(
                  child: const Text("See All",
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
