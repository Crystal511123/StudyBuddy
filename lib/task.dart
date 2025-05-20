import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shared_state.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});
  @override
  State<TaskPage> createState() => _TaskPageState();
}
class _TaskPageState extends State<TaskPage>{
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
  double titleSize=25.0;
  double subtitleSize=20.0;
  double textSize = 17.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        toolbarHeight: 65.0,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Text('Tasks', style: TextStyle(
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
            /*Container(
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
            ),*/
          ]
        ),
      ),
      body: //SafeArea( child: 
        Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            children: [
              if (Provider.of<SharedState>(context).tasks.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                  itemCount: Provider.of<SharedState>(context).tasks.length,
                  itemBuilder: (context, index) {
                    //final task = Provider.of<SharedState>(context).tasks[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4.0, left: 4, right: 4, top:2),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    //border: Border.all(color: const Color.fromARGB(173, 33, 149, 243), width:2),
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(40, 54, 165, 255),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<SharedState>(context).tasks[index]['title'],
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 23, 118, 202),
                        ),
                      ),
                      const SizedBox(height: 3),
                       Text.rich(
                        textAlign:TextAlign.start, TextSpan(
                        text: "Reward:",
                        style: TextStyle(fontSize: subtitleSize, fontWeight: FontWeight.w500, color: Colors.black),
                        children:[
                          TextSpan(
                            text:" ${Provider.of<SharedState>(context).tasks[index]['reward']}",
                            style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w400, color: Colors.black),
                          ),
                        ],
                      ), ),
                      /*Text(
                        'Reward:',
                        style: TextStyle(
                          fontSize: subtitleSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        Provider.of<SharedState>(context).tasks[index]['reward'],
                        style:  TextStyle(
                          fontSize: textSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),*/
                      const SizedBox(height: 3),
                       Text.rich(
                        textAlign:TextAlign.start, TextSpan(
                        text: "Task:",
                        style: TextStyle(fontSize: subtitleSize, fontWeight: FontWeight.w500, color: Colors.black),
                        children:[
                          TextSpan(
                            text:" ${Provider.of<SharedState>(context).tasks[index]['task']}",
                            style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w400, color: Colors.black),
                          ),
                        ],
                      ), ),
                      /*Text(
                        'Task:',
                        style: TextStyle(
                          fontSize: subtitleSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        Provider.of<SharedState>(context).tasks[index]['task'],
                        style: TextStyle(
                          fontSize: textSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),*/
                      const SizedBox(height: 3),
                      Text.rich(
                        textAlign:TextAlign.start, TextSpan(
                        text: "Progress:",
                        style: TextStyle(fontSize: subtitleSize, fontWeight: FontWeight.w500, color: Colors.black),
                        children:[
                          TextSpan(
                            text:" ${Provider.of<SharedState>(context).tasks[index]['progress']}",
                            style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w400, color: Colors.black),
                          ),
                        ],
                      ), ),
                      /*Text(
                       'Progress:',
                        style: TextStyle(
                          fontSize: subtitleSize,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,                          
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        Provider.of<SharedState>(context).tasks[index]['progress'],
                        style: TextStyle(fontSize: textSize),
                      ),*/
                      const SizedBox(height: 3),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: Provider.of<SharedState>(context).tasks[index]['progressValue'],
                          color: Colors.black,
                          backgroundColor: Colors.black12,
                          minHeight: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Provider.of<SharedState>(context).tasks[index]['progressValue'] == 1.0
                                ? Colors.blue[800]
                                : Color.fromARGB(255, 171, 184, 191),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          ),
                          onPressed:() {
                            // Remove the current task and add a new one
                            if(Provider.of<SharedState>(context, listen:false).tasks[index]['progressValue'] == 1.0){
                              Provider.of<SharedState>(context, listen: false).newTask(index,'EXP 100 + 10 blocks', 'Complete Module 2', '00:00 / 38:12', 0.0);
                              // Mark the task as seen (red dot disappears)
                              Provider.of<SharedState>(context, listen:false).markTaskAsSeen();
                            }
                          },
                          child: const Text(
                            'Receive',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
                  },
                  ),
                )
              else
                const Center(
                  child: Text(
                    'No tasks available!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),


        ),
     // ),
    );
  }
}