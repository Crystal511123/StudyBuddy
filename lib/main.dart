import 'package:flutter/material.dart';
import 'package:flutter_application_1/purchase.dart';
import 'package:provider/provider.dart';
import 'task.dart';
import 'shared_state.dart';
import 'course.dart';
import 'set_new_area.dart';
import 'land.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => SharedState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _warningPopup(context); // Show the warning popup after the widget is built
    }); 
  }
  double _scale = 1.0;
  int _lastExp = -1;
  void _triggerAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scale = 2.0;
      });
      Future.delayed(const Duration(milliseconds: 50), () {
        setState(() {
          _scale = 1.0;
        });
      });
    });
  }
  Widget _animation(BuildContext context) {
    return Selector<SharedState, int>(
      selector: (_, state) => state.exp,
      builder: (context, exp, child) {
        if (_lastExp != -1 && exp != _lastExp) {
          // EXP changed, trigger animation
          _triggerAnimation();
        }
        _lastExp = exp;
        return AnimatedScale(
          scale: _scale, // 每次 EXP 改變都重建動畫
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'EXP ${Provider.of<SharedState>(context).exp}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
  void receiveReward() {
    setState(() {
      Provider.of<SharedState>(context).hasNewTask = false;
    });
  }
  void _warningPopup(BuildContext context) {
    if (Provider.of<SharedState>(context, listen:false).payPenalty == true){ return;}
    Provider.of<SharedState>(context, listen:false).payCheck();
    showDialog(
      context: context,
      barrierDismissible: false, //  tapping outside to close
      builder: (_) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.blue[50],
          title: const Text('Warning!',style:TextStyle(fontSize: 25,fontWeight: FontWeight.w700, color: Color.fromARGB(255, 23, 106, 201))),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text.rich(
                  TextSpan(
                  text: 'You haven\'t study ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                  children: [
                    TextSpan(
                    text: 'Business English',
                    style: TextStyle(color: Color.fromARGB(255, 23, 106, 201), fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                    text: ' for 4 weeks!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Don\'t give up! 38 mins to finish module 2.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),),
                const SizedBox(height: 10),
                const Text.rich(
                  TextSpan(
                  text: 'Pay ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                  children: [
                    TextSpan(
                    text: 'Penalty: EXP 2000 ',
                    style: TextStyle(color: Color.fromARGB(255, 23, 106, 201), fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                    text: 'to keep playing.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ],
                  ),
                ),
              ],
            ),),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //side: const BorderSide(color: Color.fromARGB(255, 13, 71, 161), width: 2),
                backgroundColor: const Color.fromARGB(255, 13, 71, 161),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Provider.of<SharedState>(context, listen: false).deductExp(2000); // Deduct EXP 2000
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Pay EXP 2000',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500, color: Colors.white),),
            ),
          ],
        );
      },
    );
  }
  void _showPopup(BuildContext context, String area) {
    showDialog(
      context: context,
      barrierDismissible: true, //  tapping outside to close
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.blue[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.black),
          ),
          child: SizedBox(
            width: 300, // Set a fixed width
            height: 300, // Set a fixed height
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _popupButton("Visit", () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LandPage(area: area),
                            ),
                          );
                        }),
                        const SizedBox(height: 15),
                        _popupButton("Store", () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PurchasePage(),
                            ),
                          );
                        }),
                        const SizedBox(height: 15),
                        _popupButton("Add/Edit Courses", () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CoursePage(area: area),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                // X button in the top-right
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close popup
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _popupButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        decoration: BoxDecoration(
          //color: Colors.blue[800],
          color: const Color.fromARGB(255, 13, 71, 161),
          //border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        automaticallyImplyLeading: false,
        toolbarHeight: 65.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align items to the start (left)
          children: [
            Text('Map', style: TextStyle(
                  fontSize: 35, // Make the font size of "Map" bigger
                  fontWeight: FontWeight.w900, // Optional: Make it bold
                  color: Colors.white, // Optional: Change the color to white
                  ),
                ), // Title on the left
            Spacer(),
            IconButton(
            icon: const Icon(Icons.search, size: 35),
            color:Colors.white,
            onPressed: () {},
            ),
            InkWell(
              child: Stack(
                clipBehavior: Clip.none, // Allows the red circle to overflow if needed
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the icon and text vertically
                    children: [
                      Icon(Icons.assignment, size: 40,color: Colors.white,),
                      Text('Tasks', style: TextStyle(fontSize: 15, color: Colors.white,)), // Text below the icon
                    ],
                  ),
                  if (Provider.of<SharedState>(context).hasCompletedTask)
                    const Positioned(
                      right: -2, // Adjust the horizontal position
                      top: -2,   // Adjust the vertical position
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                      ),
                    ),
                ],
              ),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskPage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            //const SizedBox(width: 10),
            _animation(context),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left:0,
            top:0,
            child: 
              Text('Hint: Tap on the land to interact.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(224, 33, 149, 243), // Optional: Change the color to white
                ),
          ),
          ),
          Positioned(
            left: 200,
            top: 100,
            child: GestureDetector(
              onTap: () {
                _showPopup(context,'Forest');
              },
              child: Container(
                padding: EdgeInsets.all(6), // Border width
                decoration: BoxDecoration(color: const Color.fromARGB(255, 241, 220, 32), borderRadius: BorderRadius.circular(30)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('image/forest.png', scale:3.0), // Adjust the width and height as needed
                ),
              ),
            ),
          ),
          Positioned(
            left: 70,
            top: 300,
            child: GestureDetector(
              onTap: () {
                if (Provider.of<SharedState>(context, listen:false).isUnlocked ==true){
                  _showPopup(context,Provider.of<SharedState>(context, listen: false).recordName);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(6), // Border width
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 220, 32),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Provider.of<SharedState>(context).isUnlocked
                ?ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('image/barn.png', scale: 3.0),
                )
                :Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child:IconButton(
                          iconSize: 85,
                          icon: const Icon(Icons.lock_open, color: Color.fromARGB(255, 254, 254, 254)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewAreaPage(),
                              ),
                            );
                          },
                        ),
                    ), // Add spacing between the button and text
                    const Text(
                      'Unlock New Land',
                      style: TextStyle(fontSize: 16, color:Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
