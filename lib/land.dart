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
      body: SafeArea(
        child: Stack(
          children: [
            // Map icon in top-right
            Positioned(
              top: 16,
              right: 16,
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
              ),
            ),

            // Centered "Barn" text
            Center(
              child: Text(
                Provider.of<SharedState>(context, listen:false).landName(widget.area),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )
    );

  }
}
