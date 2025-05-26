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
  Future<String?> _showAddItemDialog([int? taskIndex]) async {
    final sharedState = Provider.of<SharedState>(context, listen: false);
    final TextEditingController platformNameController = TextEditingController(
      text: taskIndex != null ? sharedState.platforms[taskIndex]['pName'] ?? '' : '',
    );
    final TextEditingController userNameController = TextEditingController(
      text: taskIndex != null ? sharedState.platforms[taskIndex]['uName'] ?? '' : '',
    );
    final TextEditingController passwordController = TextEditingController(
      text: taskIndex != null ? sharedState.platforms[taskIndex]['password'] ?? '' : '',
    );
    return await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
      return StatefulBuilder(  
      builder: (context, setState)=> AlertDialog(
        title: Text(taskIndex == null ? "Add Platform" : "Edit Platform",
            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700, color: Color.fromARGB(255, 13, 71, 161)),
          ),
        content: SizedBox(
          width: 400,
          height: 250,
          child: Column(
            children:[
              Align(alignment: Alignment.centerLeft, child: Text("Platform Name:",style:TextStyle(fontSize: 18,))),
              TextField(
              style:TextStyle(fontSize:18),
                      controller: platformNameController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                        border: UnderlineInputBorder(),
                      ),
              ),
              const SizedBox(height: 8),
              Align(alignment: Alignment.centerLeft, child: Text("User Name:",style:TextStyle(fontSize: 18,))),
              TextField(
              style:TextStyle(fontSize:18),
                      controller: userNameController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                        border: UnderlineInputBorder(),
                      ),
              ),
              const SizedBox(height: 8),
              Align(alignment: Alignment.centerLeft, child: Text("Password:",style:TextStyle(fontSize: 18,))),
              TextField(
              style:TextStyle(fontSize:18),
                      controller: passwordController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4),
                        border: UnderlineInputBorder(),
                      ),
              ),
            ],
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
            },
            child: Text(taskIndex == null ?"Discard" :"Cancel", style:TextStyle(fontSize: 20,)),
          ),
          ElevatedButton(
            onPressed: passwordController.text.isNotEmpty && userNameController.text.isNotEmpty && platformNameController.text.isNotEmpty ?() async {
              int existingIndex = sharedState.platforms.indexWhere((platform) => platform['pName'] == platformNameController.text);
              
              if(taskIndex!=null){ sharedState.updatePlatformInfo(taskIndex, platformNameController.text, userNameController.text, passwordController.text);}
              else if(existingIndex!=-1){ 
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                    title: const Text("Platform Exist",style: TextStyle(color: Color.fromARGB(255, 13, 71, 161)),),
                    content:Text.rich(
                              TextSpan(
                              text: 'Updated ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                              children: [
                                TextSpan(
                                text: '${platformNameController.text}',
                                style: TextStyle(color: Colors.blue[500], fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                text: '\'s information',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                                ),
                              ],
                              ),
                            ),
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
                sharedState.updatePlatformInfo(existingIndex, platformNameController.text, userNameController.text, passwordController.text);}
              else{sharedState.addPlatform({'pName':platformNameController.text, 'uName':userNameController.text, 'password':passwordController.text});}
              Navigator.of(context).pop(platformNameController.text); // close dialog
            }:null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const Color.fromARGB(255, 171, 184, 191);
                  }
                  return Color.fromARGB(255, 13, 71, 161);
                },
              ),
            ),
            child: Text('Save', style:TextStyle(color:Colors.white,fontSize:20)),
          ),
        ],
      ),
      );},
    );
  }
  Future<void> _showEditPopup(BuildContext context, [int? taskIndex]) async {
    final sharedState = Provider.of<SharedState>(context, listen: false);
    final TextEditingController nameController = TextEditingController(
      text: taskIndex != null ? sharedState.tasks[taskIndex]['title'] ?? '' : '',
    );
    final TextEditingController linkController = TextEditingController(
      text: taskIndex != null ? sharedState.tasks[taskIndex]['link'] ?? '' : '',
    );
    int hourController = taskIndex != null ? sharedState.tasks[taskIndex]['hours'] ?? 0 : 0;
    int minuteController = taskIndex != null ? sharedState.tasks[taskIndex]['minutes'] ?? 0 : 0;
    String selectedPeriod = taskIndex != null ? sharedState.tasks[taskIndex]['period'] ?? 'Day' : 'Day';
    //String plat = '';
    //if (taskIndex == null && sharedState.platforms.isNotEmpty) plat = sharedState.platforms[0]['pName'];
    String selectPlatform = taskIndex != null ? sharedState.tasks[taskIndex]['platformName'] ?? 'add_new' : 'add_new';
    //String ? selectPlatform;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
        return AlertDialog(
          title: Text(taskIndex == null ? "Add Course" : "Edit Course",
            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700, color: Color.fromARGB(255, 13, 71, 161)),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Course Name
                const Align(alignment: Alignment.centerLeft, child: Text("Course Name:",style:TextStyle(fontSize: 18,))),
                TextField(
                  style:TextStyle(fontSize:20),
                  controller: nameController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Visibility(
                visible:taskIndex==null,
                child:Column(children:[
                const Align(alignment: Alignment.centerLeft, child: Text("Course Platform:",style:TextStyle(fontSize: 18,))),
                
              Align(
                alignment: Alignment.centerLeft,
                child: 
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setDropdownState) {
                        return DropdownButton<String>(
                          value: selectPlatform,
                          dropdownColor: const Color.fromARGB(255, 254, 254, 254),
                          hint: Text('Select platform'),
                          underline: Container(),
                          items:  [ 
                            DropdownMenuItem(
                            value: 'add_new',
                            child: Row(
                              children: [
                                Icon(Icons.add, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Add')
                              ],
                            ),
                          ),
                          if(sharedState.platforms.isNotEmpty)
                            ...sharedState.platforms.map((item) => DropdownMenuItem(
                            value: item['pName'],
                            child: Text(item['pName']),
                            )),
                          ],
                          onChanged: (value) async{
                          if (value == 'add_new') {
                            final newPlatform = await _showAddItemDialog();
                            if (newPlatform != null && newPlatform.isNotEmpty) {
                              setDropdownState(() {
                                selectPlatform = newPlatform; // Set to the newly added platform
                              });
                              setState(() {});
                            }
                        } else {
                          setDropdownState(() {
                            selectPlatform = value!;
                          });
                          setState(() {});
                        }},
                        );
                      },
                    ),),
              const SizedBox(height: 8),
                // Course Link
                
                const Align(alignment: Alignment.centerLeft, child: Text("Course Link:",style:TextStyle(fontSize: 18,))),
                TextField(
                  style:TextStyle(fontSize:20),
                  controller: linkController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4),
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                ],),),
                // Learning Goal
                const Align(alignment: Alignment.centerLeft, child: Text("Learning Goal:",style:TextStyle(fontSize: 18,))),
                //const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: [
                        //StatefulBuilder(
                          //builder: (BuildContext context, StateSetter setState) {
                            //return 
                            DropdownButton<int>(
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
                            ),//;
                          //},
                        //),
                      ],
                    ),
                    const Text("hr(s)",style:TextStyle(fontSize: 18,)),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        //StatefulBuilder(
                          //builder: (BuildContext context, StateSetter setState) {
                            //return 
                            DropdownButton<int>(
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
                            ),//;
                          //},
                        //),
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
          //),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: Text(taskIndex == null ?"Discard" :"Cancel", style:TextStyle(fontSize: 20,)),
            ),
            ElevatedButton(
              onPressed: nameController.text.isNotEmpty&&linkController.text.isNotEmpty&&(hourController!=0 || minuteController!=0)&&(selectPlatform!='add_new') ? () {
                // Update the course information in SharedState
                /*if (nameController.text.isEmpty ||
                  linkController.text.isEmpty ||
                  selectPlatform=='' ||
                  (hourController==0 && minuteController==0 )
                  ) {
                  String missingFields = '';
                  if (nameController.text.isEmpty) missingFields += '-Course Name\n';
                  if (linkController.text.isEmpty) missingFields += '-Course Link\n';
                  if (selectPlatform=='') missingFields += '-Course Platform\n';
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
                }*/
                if (taskIndex != null) {
                  sharedState.updateCourseInfo(taskIndex,
                    nameController.text,
                    linkController.text,
                    selectPlatform,
                    hourController,
                    minuteController,
                    selectedPeriod,
                  );
                } else {
                  sharedState.addTask({
                    'area': widget.area,
                    'title': nameController.text,
                    'platformName': selectPlatform,
                    'link': linkController.text,
                    'hours': hourController,
                    'minutes': minuteController,
                    'period': selectedPeriod,
                    'reward': 'Exp 350',
                    'task': '物體在空間運動中之描述(一)',
                    'progress': '00:00 / 58:27',
                    'progressValue': 0.0,
                  });

                }
                Navigator.of(context).pop(); // Close the popup
              }:null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return const Color.fromARGB(255, 171, 184, 191);
                    }
                    return Color.fromARGB(255, 13, 71, 161);
                  },
                ),
              ),
              child: const Text("Save", style:TextStyle(fontSize: 20,color:Colors.white)),
            ),
          ],
        );
      },);
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
  Future<void> _showPlatformMng(BuildContext context)async{
    final sharedState = Provider.of<SharedState>(context, listen: false);
    await showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
return AlertDialog(
  title: Text('Platform Management',
    style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700, color: Color.fromARGB(255, 13, 71, 161)),
  ),
  content: SizedBox(
    width: 400,
    height: 430,
    child: Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              await _showAddItemDialog();
              setState(() {}); // Refresh the list after adding
            },
            child: const Text(
              "Add Platform",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
              child: ListView.builder(
              itemCount: sharedState.platforms.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 4.0, top:2),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    //border: Border.all(color: const Color.fromARGB(173, 33, 149, 243), width:2),
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(40, 54, 165, 255),
                  ),
                  child: Row(
                    children:[
                      Text(
                        Provider.of<SharedState>(context).platforms[index]['pName'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 13, 71, 161),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 30),
                        color: Colors.blue[900],
                        onPressed: () {
                          _showAddItemDialog(index);
                        },
                      ),
                      IconButton(
                      icon: const Icon(Icons.delete, size: 30),
                      color: Colors.blue[900],
                      onPressed: () {
                        String plat = sharedState.platforms[index]['pName'];
                        List<int> taskIndices = sharedState.tasks
                          .asMap()
                          .entries
                          .where((entry) => entry.value['platformName'] == plat)
                          .map((entry) => entry.key)
                          .toList();
                        String related='';
                        for (int i=0;i<taskIndices.length;i++){
                          related += '-${(sharedState.tasks[taskIndices[i]]['title'])}\n';
                        }
                        if(taskIndices.isNotEmpty){
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Warning",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 13, 71, 161),
                                ),
                              ),
                              content: Text.rich(
                                TextSpan(
                                  text:'Permanently delete\n',
                                  style: TextStyle(color:Colors.black, fontSize: 17,),
                                  children:[
                                    TextSpan(
                                      text:'$plat\n$related',
                                      style: TextStyle(color:Colors.blue[700], fontSize: 17,),
                                    ),
                                    TextSpan(
                                      text:'Are you sure?',
                                      style: TextStyle(fontSize: 17,color:Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the popup
                                  },
                                  child: const Text("No", style: TextStyle(fontSize: 20)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sharedState.removeP(plat,index); // Remove the course item
                                    });
                                    Navigator.of(context).pop(); // Close the popup
                                  },
                                  child: const Text("Yes", style: TextStyle(fontSize: 20)),
                                ),
                              ],
                            );
                          },
                        );
                        }else
                        {showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Warning",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 13, 71, 161),
                                ),
                              ),
                              content: const Text(
                                "This platform will be deleted permanently. Are you sure?",
                                style: TextStyle(fontSize: 20),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the popup
                                  },
                                  child: const Text("No", style: TextStyle(fontSize: 20)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sharedState.platforms.removeAt(index); // Remove the course item
                                    });
                                    Navigator.of(context).pop(); // Close the popup
                                  },
                                  child: const Text("Yes", style: TextStyle(fontSize: 20)),
                                ),
                              ],
                            );
                          },
                        );}
                      },
                    ),
                    ], 
                  ),
                );
              },
              )   
        ),
      ],
    ),
  ),
  actions: [
    TextButton(
      onPressed: () {
        Navigator.of(context).pop(); // Close the popup
      },
      child: Text('OK', style:TextStyle(fontSize: 20,)),
    ),
  ],
);      },);
      },
    );
  }
  double textSize=17.0;
  double subtitleSize=20.0;
  double titleSize=23.0;
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
            IconButton(
              icon: const Icon(Icons.vpn_key, size: 35),
              color:Colors.white,
              onPressed: () {
                _showPlatformMng(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tree and title
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: widget.area=='Forest'?ClipOval(child: Image.asset('image/forest.png', width:200, height:200, fit:BoxFit.cover,),)
                    :ClipOval(child: Image.asset('image/${Provider.of<SharedState>(context, listen: false).selectarea}.png', width:200, height:200, fit:BoxFit.cover,),)
                  ),
                  const SizedBox(width: 20),
                  
                   Expanded(
                    child: Text(
                      Provider.of<SharedState>(context, listen: false).landName(widget.area),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
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
        Text.rich(TextSpan(
          text: "Progress: ",
          style: TextStyle(fontSize: subtitleSize, fontWeight: FontWeight.w500,),
          children:[
            TextSpan(text: "2/5 modules", style: TextStyle(fontSize: textSize,fontWeight: FontWeight.w400,),),
          ],
        ),),
        //Text("Progress:",style: TextStyle(fontSize: subtitleSize,fontWeight: FontWeight.w500,)),
        //Text("2/5 modules",style:TextStyle(fontSize: textSize,)),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 2 / 5,
              minHeight: 20,
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
        Text.rich(TextSpan(
          text: "Progress: ",
          style: TextStyle(fontSize: subtitleSize, fontWeight: FontWeight.w500,),
          children:[
            TextSpan(text: "0/7 modules", style: TextStyle(fontSize: textSize,fontWeight: FontWeight.w400,),),
          ],
        ),),
        //Text("Progress:",style:TextStyle(fontSize: subtitleSize,fontWeight: FontWeight.w500,)),
        //Text("0/6 modules",style:TextStyle(fontSize: textSize)),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0 / 7,
              minHeight: 20,
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
    int cnt = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(sharedState.tasks.length, (index) {
        if (sharedState.tasks[index]['area'] == widget.area) {
          cnt++;
          return Container(
            margin: const EdgeInsets.only(bottom: 8,), // Add spacing between items
            padding: const EdgeInsets.only(bottom:13, left:5, right:5, top:5), // Add padding inside the block
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.black), // Add a border
              borderRadius: BorderRadius.circular(8), // Rounded corners
              color: const Color.fromARGB(40, 54, 165, 255), // Background color
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "$cnt.",
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 13, 71, 161),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.drive_file_move, size: 33),
                      color: Colors.blue[900],
                      onPressed: () {
                        _showMove(context, index);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 28),
                      color: Colors.blue[900],
                      onPressed: () {
                        _showEditPopup(context, index); // Show popup for editing
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 28),
                      color: Colors.blue[900],
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Warning",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 13, 71, 161),
                                ),
                              ),
                              content: const Text(
                                "This course will be deleted permanently. Are you sure?",
                                style: TextStyle(fontSize: 20),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the popup
                                  },
                                  child: const Text("No", style: TextStyle(fontSize: 20)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sharedState.tasks.removeAt(index); // Remove the course item
                                    });
                                    Navigator.of(context).pop(); // Close the popup
                                  },
                                  child: const Text("Yes", style: TextStyle(fontSize: 20)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  sharedState.tasks[index]['title'],
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 13, 71, 161),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    if(sharedState.tasks[index]['period']=='Day') Text('Daily ', style: TextStyle(fontSize: subtitleSize, fontWeight: FontWeight.w500),),
                    if(sharedState.tasks[index]['period']=='Week') Text('Weekly ', style: TextStyle(fontSize: subtitleSize, fontWeight: FontWeight.w500),),
                    Text(
                      "Goal: ",
                      style: TextStyle(fontSize: subtitleSize, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "0:00:00 / ",
                      style: TextStyle(fontSize: textSize),
                    ),
                    Text(
                      sharedState.tasks[index]['hours'].toString(),
                      style: TextStyle(fontSize: textSize),
                    ),
                    const Text(":", style: TextStyle(fontSize: 20)),
                    Text(
                      "${sharedState.tasks[index]['minutes'].toString()}:00",
                      style: TextStyle(fontSize: textSize),
                    ),

                  ],
                ),
                Padding(
          padding: const EdgeInsets.only(right: 20, top: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0 / 6,
              minHeight: 20,
              backgroundColor:  const Color.fromARGB(99, 125, 160, 177),
              color: Colors.black,
            ),
          ),
        ),
                index == 0 ? haveProgress() : noProgress(),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink(); // Return an empty widget for non-matching tasks
        }
      }),
    );
  }
}
