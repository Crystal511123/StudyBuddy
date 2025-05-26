import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shared_state.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});
  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  int bushCount = 0;
  int appleTreeCount = 0;
  int roseBushCount = 0;
  int cactusCount = 0;
  int elfCount = 0;
  int cowboyCount = 0;
  int androidCount = 0;
  int farmBoyCount = 0;

  int get totalExp =>
      bushCount * 120 +
      appleTreeCount * 250 +
      roseBushCount * 300 +
      cactusCount * 300 +
      elfCount * 1000 +
      cowboyCount * 1200 +
      androidCount * 1250 +
      farmBoyCount * 1300;


  late int maxExp;

  @override
  void initState() {
    super.initState();
    maxExp = Provider.of<SharedState>(context, listen: false).exp;
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
            TextSpan(text: 'EXP $cost', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color:Colors.blue[500]),),
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
          child: Text('$count',style:TextStyle(fontSize: 18),),
        ),
        IconButton(onPressed: onIncrement, icon: Icon(Icons.add)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        toolbarHeight: 65.0,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Text('Store', style: TextStyle(
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
            _animation(context),
          ]
        ),
        bottom: const TabBar(
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 25.0, fontWeight:FontWeight.bold, color:Colors.white),  //For Selected tab
          unselectedLabelStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color:Colors.white),
          tabs: <Widget>[
            Tab(text: 'Items',),
            Tab(text: 'Characters'),
          ],)
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Items
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'image/bush.png',
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
                              'image/appletree.png',
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
                              'image/rosebush.png',
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
                              'image/cactus.png',
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
                        //SizedBox(he
                      ],
                    ),
                  ),
                ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'image/elf.png',
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
                              'image/cowboy.png',
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'image/android.png',
                              scale: 3.0,
                              width: 80, // Adjust the width of the image
                              height: 80, // Adjust the height of the image
                            ),
                            const SizedBox(width: 10), // Add spacing between the image and the text
                            Expanded(
                            child: itemRow("Android", 1250, androidCount,
                              () => increment(() => androidCount, (v) => androidCount = v, 1200),
                              () => decrement(() => androidCount, (v) => androidCount = v)),
                            ),
                          ],
                        ), 
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'image/farm_boy.png',
                              scale: 3.0,
                              width: 80, // Adjust the width of the image
                              height: 80, // Adjust the height of the image
                            ),
                            const SizedBox(width: 10), // Add spacing between the image and the text
                            Expanded(
                            child: itemRow("Farmer", 1300, farmBoyCount,
                              () => increment(() => farmBoyCount, (v) => farmBoyCount = v, 1200),
                              () => decrement(() => farmBoyCount, (v) => farmBoyCount = v)),
                            ),
                          ],
                        ),  
                        //SizedBox(he
                      ],
                    ),
                  ),
                ),
          ),
              ],
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
                SizedBox(
                  width:200,
                child: 
                  ElevatedButton(
                  style: ElevatedButton.styleFrom( backgroundColor: const Color.fromARGB(255, 13, 71, 161),
                    ),
                  onPressed: totalExp <= maxExp ? () {
                    setState(() {
                      Provider.of<SharedState>(context, listen:false).deductExp(totalExp);
                      //Provider.of<SharedState>(context, listen: false).exp -= totalExp; // Deduct the total EXP
                      // Reset counts for all items
                      bushCount = 0;
                      appleTreeCount = 0;
                      roseBushCount = 0;
                      cactusCount = 0;
                      elfCount = 0;
                      cowboyCount = 0;
                      androidCount = 0;
                      farmBoyCount = 0;
                      maxExp = Provider.of<SharedState>(context, listen: false).exp ; // Reset total EXP
                    });
                  } : null,
                  child: Text("Buy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                ),
                ),
              ],
            )
          ),//Cal exp
        ],
        )
      
    ),
    );
  }
}
