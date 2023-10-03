import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Future<bool> connectionCheck() async {
//   bool result = await InternetConnectionChecker().hasConnection;
//   return result;
// }

// class InternetChecking extends StatelessWidget {
//   const InternetChecking({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: ma,
//       children: [
//         hasConnection(context)
//       ],
//     );
//   }

//   hasConnection(context) async {
//     if (await connectionCheck()) {
//       Messenger.pop(msg: 'No Internet', context: context);
//     }
//   }
// }

class InternetChecking extends StatelessWidget {
  const InternetChecking({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InternetStatusWidget(),
    );
  }
}

class InternetStatusWidget extends StatelessWidget {
  const InternetStatusWidget({super.key});

  Future<bool> checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkConnection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.active) {
            return const Center(child: Text('Internet is available.'));
          } else {
            return const Center(child: Text('No Internet'));
          }
        } else {
          return const Center(child: Text('Connection Error'));
        }
      },
    );
  }
}
