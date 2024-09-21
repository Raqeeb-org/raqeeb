import 'package:flutter/material.dart';
import 'package:raqeeb/widgets/childCard.dart';

class MorningBusChildren extends StatelessWidget {
  const MorningBusChildren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 236, 242),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Assigned Children',
            style: TextStyle(
              fontFamily: 'Poppins', //change font later
              fontSize: 25,
              color: Color.fromARGB(255, 247, 164, 0),
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                ChildCard(
                  name: 'Khaled',
                  id: 'GAG17236H',
                  eta: '6:00',
                  imageUrl: 'assets/images/khaled.jpg',
                  isCheckedIn: false,
                  isCallEnabled: true,
                ),
                ChildCard(
                  name: 'Deena',
                  id: 'GAG17236H',
                  eta: '6:30',
                  imageUrl: 'assets/images/deena.jpg',
                  isCheckedIn: true,
                  isCallEnabled: true,
                ),
                ChildCard(
                  name: 'Haneen',
                  id: 'GAG17236H',
                  eta: '6:45',
                  imageUrl: 'assets/images/haneen.jpg',
                  isCheckedIn: false,
                  isCallEnabled: true,
                ),
                ChildCard(
                  name: 'Azeez',
                  id: 'GAG17236H',
                  eta: '7:15',
                  imageUrl: 'assets/images/azeez.jpg',
                  isCheckedIn: false,
                  isCallEnabled: true,
                ),
                ChildCard(
                  name: 'Abdullah',
                  id: 'GAG17236H',
                  eta: '7:34',
                  imageUrl: 'assets/images/abdullah.jpg',
                  isCheckedIn: true,
                  isCallEnabled: true,
                ),
              ],
            ),
          ),
          // Bottom navigation bar
        ],
      ),
    );
  }
}
