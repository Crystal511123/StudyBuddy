import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shared_state.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        toolbarHeight: 70.0,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              if (Provider.of<SharedState>(context).tasks.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                  itemCount: Provider.of<SharedState>(context).tasks.length,
                  itemBuilder: (context, index) {
                    //final task = Provider.of<SharedState>(context).tasks[index];
                    return Container(
                  padding: const EdgeInsets.all(16),
                  /*decoration: BoxDecoration(
                  //  border: Border.all(color: const Color.fromARGB(255, 205, 187, 27), width:2),
                  //  borderRadius: BorderRadius.circular(8),
                  //  color: Colors.yellow[200],
                  ),*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<SharedState>(context).tasks[index]['title'],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 23, 118, 202),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Reward:',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        Provider.of<SharedState>(context).tasks[index]['reward'],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Task:',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        Provider.of<SharedState>(context).tasks[index]['task'],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Progress:',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,                          
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        Provider.of<SharedState>(context).tasks[index]['progress'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: Provider.of<SharedState>(context).tasks[index]['progressValue'],
                          color: Colors.black,
                          backgroundColor: Colors.black12,
                          minHeight: 12,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Provider.of<SharedState>(context).tasks[index]['progressValue'] == 1.0
                                ? Colors.blue[800]
                                : Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          ),
                          onPressed:() {
                            // Remove the current task and add a new one
                            if(Provider.of<SharedState>(context, listen:false).tasks[index]['progressValue'] == 1.0){
                              Provider.of<SharedState>(context, listen: false).newTask(index,'EXP 100 + expend 10 blocks', 'Complete Module 2', '00:00 / 38:12', 0.0);
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
      ),
    );
  }
}