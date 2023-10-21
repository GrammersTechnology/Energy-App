import 'package:demo/utils/const/space_helper.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/primary_button.dart';
import 'package:demo/utils/const/widgets/byge-design-system/buttons/toggle_button.dart';
import 'package:demo/utils/const/widgets/byge-design-system/cards/expandable_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profil',
              style: TextStyle(fontSize: 24),
            ),
            vSpaceRegular,
            BygeExpandableCard(
              title: "Din konto",
              subtitle: 'Logg ut, bytt passord og samtykke',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Magnus.mo@hkraft.com',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 73, 73, 73)),
                  ),
                  vSpaceSmall,
                  const Text(
                    'Samtykker du til at vi kan sende deg ja markedsføringsmateriell',
                    style: TextStyle(fontSize: 14),
                  ),
                  vSpaceRegular,
                  BygePrimaryButton(
                    label: "Logg ut",
                    onPressed: () {
                      // Replace the current content with the "hello" content
                    },
                    labelColor: Colors.black,
                    color: Colors.white,
                    borderColor: const Color(0XFF404040),
                  ),
                  vSpaceSmall,
                  BygePrimaryButton(
                    label: "Slett konto",
                    labelColor: Colors.black,
                    onPressed: () {
                      // Replace the current content with the "hello" content
                    },
                    color: Colors.white,
                    borderColor: const Color(0XFF404040),
                  ),
                  vSpaceSmall,
                  BygePrimaryButton(
                    label: "Lagre endringer",
                    onPressed: () {
                      // Replace the current content with the "hello" content
                    },
                    color: const Color(0XFF404040),
                  ),
                ],
              ),
            ),
            vSpaceRegular,
            const BygeExpandableCard(
                title: "Ditt hjem",
                subtitle:
                    'Informasjon om din bolig, strømleverandør og forbruk',
                child: Text("data")),
            vSpaceRegular,
            const BygeExpandableCard(title: "Strøm", child: Text("data")),
            vSpaceRegular,
            BygeExpandableCard(
                title: "Pushvarslinger",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Motta varsel med strømpriser\nfor neste dag',
                          style: TextStyle(fontSize: 14),
                        ),
                        BygeToggleButton(
                          toggled: false,
                          toggleText: "",
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                    vSpaceRegular,
                    BygePrimaryButton(
                      label: "Lagre endringer",
                      onPressed: () {
                        // Replace the current content with the "hello" content
                      },
                      color: const Color(0XFF404040),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
