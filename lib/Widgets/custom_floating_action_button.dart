
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FabCircularMenuPlus(
      fabColor: Colors.deepPurple,
      ringDiameter: 220,
      ringWidth: 10,
      ringColor: Colors.transparent,
      fabOpenIcon: const Icon(
        Icons.add,
        size: 45,
        color: Colors.white,
      ),
      fabCloseIcon: const Icon(
        Icons.close,
        size: 45,
        color: Colors.white,
      ),
      alignment: Alignment.bottomCenter,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green,
          child: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const IncomePage(),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.unarchive,
              color: Colors.white,
            ),
          ),
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blue,
          child: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const Transfer(),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.device_hub,
              color: Colors.white,
            ),
          ),
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.red,
          child: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const Expense(),
                //),
             // );
            },
            icon: const Icon(
              Icons.move_to_inbox,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
