import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shared_state.dart';
import 'land.dart';

class NewAreaPage extends StatefulWidget {
  const NewAreaPage({super.key});
  @override
  State<NewAreaPage> createState() => _NewAreaPageState();
}

class _NewAreaPageState extends State<NewAreaPage> {
  int bushCount = 0;
  int appleTreeCount = 0;
  int roseBushCount = 0;
  int cactusCount = 0;
  int elfCount = 0;
  int cowboyCount = 0;
  final TextEditingController landName=TextEditingController(text:'');
  String? selectedBackground; // Tracks the selected background

  int get totalExp =>
      bushCount * 120 +
      appleTreeCount * 250 +
      roseBushCount * 300 +
      cactusCount * 300 +
      elfCount * 1000 +
      cowboyCount * 1200;

  late int maxExp;

  @override
  void initState() {
    super.initState();
    maxExp = Provider.of<SharedState>(context, listen: false).exp;
  }

  void increment(Function getter, Function setter, int cost) {
    if (totalExp + cost <= maxExp) {
      setState(() {
        setter(getter() + 1);
      });
    }
  }

  void decrement(Function getter, Function setter) {
    if (getter() > 0) {
      setState(() {
        setter(getter() - 1);
      });
    }
  }

  Widget itemRow(String label, int cost, int count, VoidCallback onIncrement, VoidCallback onDecrement) {
    return Row(
      children: [
        Text.rich(TextSpan(
          text: '$label:\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          children:[ 
            TextSpan(text: 'EXP $cost', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),
          ],
        )),
        Spacer(),
        IconButton(onPressed: onDecrement, icon: Icon(Icons.remove)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('$count', style: TextStyle(fontSize: 18),),
        ),
        IconButton(onPressed: onIncrement, icon: Icon(Icons.add)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final double wordSize=18.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        toolbarHeight: 65.0,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Text('Set up', style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.white
                  ),
                ),
            Spacer(),
            IconButton(
            icon: const Icon(Icons.search, size: 35),
            color:Colors.white,
            onPressed: () {},
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width:2),
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
          ]
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                Row(
                  children: [
                    Text("Name:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color:Color.fromARGB(255, 23, 118, 202)),),
                      Expanded(
                        child: TextField(
                          style:TextStyle(fontSize:20),
                          controller: landName,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            border: UnderlineInputBorder(),
                            hintText: 'New Land Name',
                            hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                ),
                const SizedBox(height: 20),
                Text("Background", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color:Color.fromARGB(255, 23, 118, 202)),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      Text('Forest',style: TextStyle(fontWeight: FontWeight.bold, fontSize: wordSize),),
                      Spacer(),
                      Transform.scale(
                        scale:2,
                        child: 
                          Checkbox(
                            value: selectedBackground == 'Forest',
                            onChanged: (bool? value) {
                              setState(() {
                                selectedBackground = value == true ? 'Forest' : null;
                              });
                            },
                          ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/barn.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      Text('Barn',style: TextStyle(fontWeight: FontWeight.bold, fontSize: wordSize),),
                      Spacer(),
                      Transform.scale(
                        scale:2,
                        child: 
                          Checkbox(
                            value: selectedBackground == 'Barn',
                            onChanged: (bool? value) {
                              setState(() {
                                selectedBackground = value == true ? 'Barn' : null;
                              });
                            },
                          ),
                      )
                      
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      RichText( text: TextSpan( children: [
                        TextSpan(
                          text: "Cyberpunk\n",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: wordSize, color: Colors.grey),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.lock, size: 18,color:Colors.grey,),
                        ),
                        TextSpan(
                          text: "EXP > 6000",
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: wordSize, color: Colors.grey),
                        ),
                      ], ), ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      RichText( text: TextSpan( children: [
                        TextSpan(
                          text: "Wild West\n",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: wordSize, color: Colors.grey),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.lock, size: 18,color:Colors.grey,),
                        ),
                        TextSpan(
                          text: "Study >10 hours",
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: wordSize, color: Colors.grey),
                        ),
                      ], ), ),
                    ],
                  ),
                  // Items
                  Text("Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color:Color.fromARGB(255, 23, 118, 202)),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      Expanded(
                      child: itemRow("Bush",120,bushCount,
                        () => increment(() => bushCount, (v) => bushCount = v, 120),
                        () => decrement(() => bushCount, (v) => bushCount = v),
                      ),
                      ),
                    ],
                  ), 
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      Expanded(
                      child: itemRow("Apple tree", 250, appleTreeCount,
                        () => increment(() => appleTreeCount, (v) => appleTreeCount = v, 250),
                        () => decrement(() => appleTreeCount, (v) => appleTreeCount = v)),
                      ),
                    ],
                  ), 
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      Expanded(
                      child: itemRow("Rose Bush", 300, roseBushCount,
                        () => increment(() => roseBushCount, (v) => roseBushCount = v, 300),
                        () => decrement(() => roseBushCount, (v) => roseBushCount = v)),
                      ),
                    ],
                  ), 
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      Expanded(
                      child: itemRow("Cactus", 300, cactusCount,
                        () => increment(() => cactusCount, (v) => cactusCount = v, 300),
                        () => decrement(() => cactusCount, (v) => cactusCount = v)),
                      ),
                    ],
                  ), 
                  SizedBox(height: 20),

                  // Characters
                  Text("Characters", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color:Color.fromARGB(255, 23, 118, 202))),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      Expanded(
                      child: itemRow("Elf", 1000, elfCount,
                        () => increment(() => elfCount, (v) => elfCount = v, 1000),
                        () => decrement(() => elfCount, (v) => elfCount = v)),
                      ),
                    ],
                  ), 
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'image/forest.png',
                        scale: 3.0,
                        width: 80, // Adjust the width of the image
                        height: 80, // Adjust the height of the image
                      ),
                      const SizedBox(width: 10), // Add spacing between the image and the text
                      Expanded(
                      child: itemRow("Cowboy", 1200, cowboyCount,
                        () => increment(() => cowboyCount, (v) => cowboyCount = v, 1200),
                        () => decrement(() => cowboyCount, (v) => cowboyCount = v)),
                      ),
                    ],
                  ), 
                  //SizedBox(he
                ],
              ),
            ),
          ),
          ),
          Container(
            color:Colors.blue[50],
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrinks to fit content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Total EXP: $totalExp", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color:Color.fromARGB(255, 23, 118, 202)),),
                Text("Remain EXP: ${maxExp - totalExp}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color:Color.fromARGB(255, 23, 118, 202)),),
                ElevatedButton(
                  style: ElevatedButton.styleFrom( backgroundColor: const Color.fromARGB(255, 13, 71, 161),),
                  onPressed: totalExp <= maxExp ? () {
                    if(landName.text.isEmpty) {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Missing Name',style: TextStyle(color: Color.fromARGB(255, 13, 71, 161))),
                            content: Text('Please enter a name for this land.',style: TextStyle(fontSize: 18),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }else if (selectedBackground==null){
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Missing Background',style: TextStyle(color: Color.fromARGB(255, 13, 71, 161))),
                            content: Text('Please select a background for this land.',style: TextStyle(fontSize: 18),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    Provider.of<SharedState>(context, listen: false).unlockArea();
                    Provider.of<SharedState>(context, listen: false).exp -= totalExp; // Update the total exp in SharedState
                    Provider.of<SharedState>(context, listen: false).setRecordName(landName.text); // Update the record name in SharedState
                    Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LandPage(area:'Barn'),
                        ),
                      );
                    // Navigate back to the main page
                  } : null,
                  child: Text("Buy & Visit new land", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                ),
              ],
            )
              
             
            
            
          ),
        ],
        )
      
    );
  }
}
