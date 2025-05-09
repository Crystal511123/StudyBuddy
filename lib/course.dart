import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shared_state.dart';

class CoursePage extends StatefulWidget {
  final String area;
  const CoursePage({super.key,required this.area});
  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  void _showEditPopup(BuildContext context, [int? taskIndex]) {
    final sharedState = Provider.of<SharedState>(context, listen: false);
    final TextEditingController nameController = TextEditingController(
      text: taskIndex != null ? sharedState.tasks[taskIndex]['title'] ?? '' : '',
    );
    final TextEditingController linkController = TextEditingController(
      text: taskIndex != null ? sharedState.tasks[taskIndex]['link'] ?? '' : '',
    );
    final TextEditingController userNameController = TextEditingController(
      text: taskIndex != null ? sharedState.tasks[taskIndex]['userName'] ?? '' : '',
    );
    final TextEditingController accessController = TextEditingController(
      text: taskIndex != null ? sharedState.tasks[taskIndex]['access'] ?? '' : '',
    );
    int hourController = taskIndex != null ? sharedState.tasks[taskIndex]['hours'] ?? 0 : 0;
    int minuteController = taskIndex != null ? sharedState.tasks[taskIndex]['minutes'] ?? 0 : 0;
    String selectedPeriod = taskIndex != null ? sharedState.tasks[taskIndex]['period'] ?? 'Day' : 'Day';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(taskIndex == null ? "Add Course" : "Edit Course",
            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700, color: Color.fromARGB(255, 13, 71, 161)),
          ),
          content: SizedBox(
            width: 400,
            height: 430,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Course Name
                const Align(alignment: Alignment.centerLeft, child: Text("Course Name:",style:TextStyle(fontSize: 18,))),
                TextField(
                  style:TextStyle(fontSize:20),
                  controller: nameController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),

                // Course Link
                const Align(alignment: Alignment.centerLeft, child: Text("Course Link:",style:TextStyle(fontSize: 18,))),
                TextField(
                  style:TextStyle(fontSize:20),
                  controller: linkController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: UnderlineInputBorder(),
                  ),
                ),

                //User Name
                const SizedBox(height: 8),
                const Align(alignment: Alignment.centerLeft, child: Text("User Name:",style:TextStyle(fontSize: 18,))),
                TextField(
                  style:TextStyle(fontSize:20),
                  controller: userNameController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                // Access
                const Align(alignment: Alignment.centerLeft, child: Text("Password:",style:TextStyle(fontSize: 18,))),
                TextField(
                  style:TextStyle(fontSize:20),
                  controller: accessController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                // Learning Goal
                const Align(alignment: Alignment.centerLeft, child: Text("Learning Goal:",style:TextStyle(fontSize: 18,))),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: [
                        StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return DropdownButton<int>(
                              value: hourController,
                              dropdownColor: const Color.fromARGB(255, 254, 254, 254),
                              underline: Container(),
                              items: List<DropdownMenuItem<int>>.generate(
                                24,
                                (int index) {
                                  return DropdownMenuItem<int>(
                                    value: index,
                                    child: Text('$index',style:TextStyle(fontSize:20),),
                                  );
                                },
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  hourController = value!;
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const Text("hr(s)",style:TextStyle(fontSize: 18,)),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return DropdownButton<int>(
                              value: minuteController,
                              dropdownColor: const Color.fromARGB(255, 254, 254, 254),
                              //style: const TextStyle(color: Colors.blue),
                              underline: Container(),
                              items: List<DropdownMenuItem<int>>.generate(
                                60,
                                (int index) {
                                  return DropdownMenuItem<int>(
                                    value: index,
                                    child: Text('$index',style:TextStyle(fontSize:20),),
                                  );
                                },
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  minuteController = value!;
                                });
                              },
                            );
                          },
                        ),
                      ],
                      ),
                      const Text("min(s)",style:TextStyle(fontSize: 18,)),
                      ],
                    ),
                
                Row(
                  children: [
                    const Text("per",style:TextStyle(fontSize: 18,)),
                    const SizedBox(width: 6),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return DropdownButton<String>(
                          value: selectedPeriod,
                          dropdownColor: const Color.fromARGB(255, 254, 254, 254),
                          underline: Container(),
                          items: const [
                            DropdownMenuItem(value: 'Day', child: Text("Day",style:TextStyle(fontSize:20),)),
                            DropdownMenuItem(value: 'Week', child: Text("Week",style:TextStyle(fontSize:20),)),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedPeriod = value!;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: Text(taskIndex == null ?"Discard" :"Cancel", style:TextStyle(fontSize: 20,)),
            ),
            ElevatedButton(
              onPressed: () {
                // Update the course information in SharedState
                if (nameController.text.isEmpty ||
                  linkController.text.isEmpty ||
                  userNameController.text.isEmpty ||
                  accessController.text.isEmpty ||
                  (hourController==0 && minuteController==0 )
                  ) {
                  String missingFields = '';
                  if (nameController.text.isEmpty) missingFields += '-Course Name\n';
                  if (linkController.text.isEmpty) missingFields += '-Course Link\n';
                  if (userNameController.text.isEmpty) missingFields += '-User Name\n';
                  if (accessController.text.isEmpty) missingFields += '-Password\n';
                  if (minuteController==0 && hourController==0) missingFields += '-Learning Goal\n';

                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                    title: const Text("Missing Fields",style: TextStyle(color: Color.fromARGB(255, 13, 71, 161)),),
                    content: Text("Please fill in the following fields:\n$missingFields",),
                    actions: [
                      TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the popup
                      },
                      child: const Text("OK"),
                      ),
                    ],
                    );
                  },
                  );
                  return; // Do not proceed if any field is empty
                }
                if (taskIndex != null) {
                  sharedState.updateCourseInfo(taskIndex,
                    nameController.text,
                    linkController.text,
                    userNameController.text,
                    accessController.text,
                    hourController,
                    minuteController,
                    selectedPeriod,
                  );
                } else {
                  sharedState.addTask({
                    'area': widget.area,
                    'title': nameController.text,
                    'link': linkController.text,
                    'access': accessController.text,
                    'userName': userNameController.text,
                    'hours': hourController,
                    'minutes': minuteController,
                    'period': selectedPeriod,
                    'reward': 'Exp 350',
                    'task': 'Finish Module 1',
                    'progress': '00:00 / 45:21',
                    'progressValue': 0.0,
                  });

                }
                Navigator.of(context).pop(); // Close the popup
              },
              child: const Text("Save", style:TextStyle(fontSize: 20,)),
            ),
          ],
        );
      },
    );
  }
  void _showMove(BuildContext context, int taskIndex){
    final sharedState = Provider.of<SharedState>(context, listen: false);
    String targetArea = sharedState.tasks[taskIndex]['area'];
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Move",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w700, color: Color.fromARGB(255, 13, 71, 161))),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text.rich(
                  textAlign:TextAlign.start, TextSpan(
                  text: "Move ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                  children:[
                    TextSpan(
                      text:"${sharedState.tasks[taskIndex]['title']} ",
                      style: TextStyle(fontSize:20, color: Color.fromARGB(255, 23, 106, 201), fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: "to",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ],
                ),), //rich
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return DropdownButton<String>(
                      value: targetArea,
                      dropdownColor: const Color.fromARGB(255, 254, 254, 254),
                      underline: Container(),
                      items: [
                        DropdownMenuItem(value: 'Forest', child: Text("Forest",style:TextStyle(fontSize:20),)),
                        if (sharedState.recordName!='') DropdownMenuItem(value: sharedState.recordName, child: Text("${sharedState.recordName}",style:TextStyle(fontSize:20),)),
                      ],
                      onChanged: (value) {
                        setState(() {
                          targetArea = value!;
                        });
                      },
                    );
                  },
              ),
              ],),
          //),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: const Text("Cancel",style: TextStyle(fontSize: 20)),
            ),
            ElevatedButton(
              onPressed: () {
                sharedState.moveCourse(taskIndex,targetArea);
                Navigator.of(context).pop(); // Close the popup
              },
              child: const Text("Move",style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
     );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        toolbarHeight: 65.0,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Courses",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Colors.white)),
            Spacer(),
            IconButton(
            icon: const Icon(Icons.search, size: 35),
            color:Colors.white,
            onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tree and title
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: ClipOval(child: Image.asset('image/forest.png', width:200, height:200, fit:BoxFit.cover,),)
                  ),
                  const SizedBox(width: 20),
                  
                  Text(
                    Provider.of<SharedState>(context, listen: false).landName(widget.area),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Add Course button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _showEditPopup(context); // Call without taskIndex to add a new course
                  },
                  child: const Text(
                    "Add Course",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Course Card
              _courseItem(),
            ],
          ),
        ),
      ),
    );
  }
  Widget haveProgress(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Progress:",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,)),
        const Text("2/5 modules",style:TextStyle(fontSize: 20,)),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 2 / 5,
              minHeight: 12,
              backgroundColor: const Color.fromARGB(99, 125, 160, 177),
              color: Colors.blue[800],
            ),
          ),
        ),
      ],
    );
  }
  Widget noProgress(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Text("Progress:",style:TextStyle(fontSize: 23,fontWeight: FontWeight.w700,)),
        Text("0/6 modules",style:TextStyle(fontSize: 20)),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0 / 6,
              minHeight: 12,
              backgroundColor:  const Color.fromARGB(99, 125, 160, 177),
              color: Colors.black,
            ),
          ),
        ),
      ]
    );
  }
  Widget _courseItem() {
    final sharedState = Provider.of<SharedState>(context);
    int cnt=0;
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(sharedState.tasks.length, (index){
      if (sharedState.tasks[index]['area'] == widget.area) {
        cnt++;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          children:[
          Text("$cnt.",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 13, 71, 161)),
          ),
          Spacer(),
          IconButton(
          icon: const Icon(Icons.drive_file_move, size: 35),
          color:Colors.blue[900],
          onPressed: () {
            _showMove(context, index);
          },
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 30),
            color:Colors.blue[900],
            onPressed: () {
            _showEditPopup(context, index); // Show popup for editing
            },
          ),
          //const SizedBox(width: 2),
          IconButton(
            icon: const Icon(Icons.delete, size: 30),
            color: Colors.blue[900],
            onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Warning",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w700, color: Color.fromARGB(255, 13, 71, 161))),
                content: const Text("This course will be deleted permanently. Are you sure?", style: TextStyle(fontSize: 20)),
                actions: [
                ElevatedButton(
                  onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                  },
                  child: const Text("No",style: TextStyle(fontSize: 20)),
                ),
                TextButton(
                  onPressed: () {
                  setState(() {
                    sharedState.tasks.removeAt(index); // Remove the course item
                  });
                  Navigator.of(context).pop(); // Close the popup
                  },
                  child: const Text("Yes",style: TextStyle(fontSize: 20)),
                ),
                ],
              );
              },
            );
            },
          ),
          ]
        ),
        
        Row(
          children: [
          const Text("Course Name: ", style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,)),
          ],
        ),
        Text(
          sharedState.tasks[index]['title'],
          style: const TextStyle(
          fontSize: 20,
          decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 4),
        const Text("Course Link:",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,)),
        SingleChildScrollView(
          //for horizontal scrolling
          scrollDirection: Axis.horizontal,
          child: Text(
            sharedState.tasks[index]['link'],
            style: const TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 20,
            color: Color.fromARGB(255, 42, 99, 145),
          ),
          ),
        ),
        const SizedBox(height: 4),
        const Text("User Name:",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,)),
        SingleChildScrollView(
          //for horizontal scrolling
          scrollDirection: Axis.horizontal,
          child: Text(
            sharedState.tasks[index]['userName'],
            style: const TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 20,
          ),
          ),
        ),
        const SizedBox(height: 4),
        const Text("Password:",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,)),
        Text(
          sharedState.tasks[index]['access'],
          style: const TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        const Text("Learning Goal:",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,)),
        Row(
          children: [
          Text(sharedState.tasks[index]['hours'].toString(),
            style: const TextStyle(decoration: TextDecoration.underline,fontSize: 20,),),
          const SizedBox(width: 8),
          const Text("hr(s)",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w400,)),
          const SizedBox(width: 15),
          Text(sharedState.tasks[index]['minutes'].toString(),
            style: const TextStyle(decoration: TextDecoration.underline,fontSize: 20,),),
          const SizedBox(width: 8),
          const Text("min(s)", style:TextStyle(fontSize: 20,fontWeight: FontWeight.w400,)),
          ],
        ),
        Row(
          children:[
            const Text("per", style:TextStyle(fontSize: 20,fontWeight: FontWeight.w400,)),
            const SizedBox(width: 10),
            SizedBox(
                width: 60,
                child: Text(
                sharedState.tasks[index]['period'],
                style: const TextStyle(decoration: TextDecoration.underline,fontSize: 20,),
                ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        index == 0 ? haveProgress() : noProgress(),
        const SizedBox(height: 25),
        ],
      );
      } else {
      return const SizedBox.shrink(); // Return an empty widget for non-matching tasks
      }
    })
    );
  }
}
