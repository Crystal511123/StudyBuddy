import 'package:flutter/material.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'shared_state.dart';
class LandPage extends StatefulWidget {
  final String area;
  const LandPage({super.key, required this.area});
  @override
  State<LandPage> createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  // Your state variables here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //SafeArea(
        //child: 
        Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/barnarea.png'), // Path to your image
            fit: BoxFit.cover, // Ensures the image fills the entire background
          ),
        ),
          child: Stack(
          children: [
            // Map icon in top-right
            Positioned(
              top: 23,
              right: 18,
              child: Container(
              width: 60, // make sure width = height
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue[900], // background color
                borderRadius: BorderRadius.circular(10), // optional for rounded square
              ),
              child: IconButton(
                iconSize:50,
                icon: Icon(Icons.map, color: Colors.white),
                onPressed: () {
                   Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
              ),
            )
              /*
              child: IconButton(
                iconSize:50,
                icon: Icon(Icons.map),
                color: Colors.blue[900],
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
              ),*/
            ),

            // Centered "Barn" text
            /*
            Center(
              child: Text(
                Provider.of<SharedState>(context, listen:false).landName(widget.area),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),*/
          ],
        ),),
      //)
    );

  }
}
