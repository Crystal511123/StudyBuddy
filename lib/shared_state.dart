import 'package:flutter/material.dart';

class SharedState extends ChangeNotifier {
   
  List<Map<String, dynamic>> tasks = [
    {
      'area': 'Forest',
      'title': 'Business English',
      'reward': 'Exp 200',
      'task': 'Complete Module 1',
      'progress': '30:34 / 30:34',
      'progressValue': 1.0,
      'link':'coursera.org/learn/Business-English',
      'platformName': 'Coursera',
      'hours':1,
      'minutes': 30,
      'period':'Day',

    },
  ];
  List<Map<String, dynamic>> platforms = [
    {
      'pName':'Coursera',
      'uName': 'Crystal Kuo',
      'password':'0123456789',
    },
  ];
  bool hasNewTask = true;
  var exp = 6000;
  bool payPenalty = false;
  void payCheck(){
    payPenalty = true;
    notifyListeners();
  }
  void deductExp(int amount) {
    exp -= amount;
    notifyListeners(); // Notify listeners to update the UI
  }
  void updateCourseName(int index, String newName) {
    tasks[index]['title'] = newName; // Update the course name
    notifyListeners(); // Notify listeners about the change
  }
  void markTaskAsSeen() {
    hasNewTask = false; // Mark the task as seen
    notifyListeners();
  }
  void updateCourseInfo(int index, String newCourseName, String newCourseLink, String newPlatformName, int newCourseHours,int newCourseMinutes, String newCoursePeriod) {
    tasks[index]['title'] = newCourseName; // Update the course name
    tasks[index]['link'] = newCourseLink; // Update the course name
    tasks[index]['platformName'] = newPlatformName; 
    tasks[index]['hours'] = newCourseHours;
    tasks[index]['minutes'] = newCourseMinutes;
    tasks[index]['period'] = newCoursePeriod;// Update the course name
    notifyListeners(); // Notify listeners about the change
  }
  void newTask(int index, String newReward, String newTasks, String newProgress, double newProgressValue) {
    tasks[index]['reward'] = newReward; // Update the course name
    tasks[index]['task'] = newTasks; // Update the course name
    tasks[index]['progress'] = newProgress; // Update the course name
    tasks[index]['progressValue'] = newProgressValue; // Update the course name
    deductExp(-200);
    notifyListeners(); // Notify listeners about the change
  }
  void addTask(Map<String, dynamic> task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }
  bool get hasCompletedTask {
    return tasks.any((task) => task['progressValue'] == 1.0);
  }

  bool isUnlocked = false;
  void unlockArea() {
    isUnlocked = true;
    notifyListeners(); // Notify listeners to update the UI
  }
  String recordName='';
  void setRecordName(String name) {
    recordName = name; // Update the course name
    //print('recordName: $recordName');
    notifyListeners(); // Notify listeners about the change
  }
  String landName(String name) {
    if(name=='Forest') {return 'Forest';}
    else {return recordName;}// Update the course name // Notify listeners about the change
  }
  void moveCourse(int index, String area){
    tasks[index]['area'] = area; // Update the course name
    notifyListeners(); // Notify listeners about the change
  }
  void addPlatform(Map<String, dynamic> platform) {
    platforms.add(platform);
    notifyListeners();
  }
  void updatePlatformInfo(int index, String newPlatformName, String newUserName, String newPassword) {
    String target = platforms[index]['pName'];
    List<int> taskIndices = tasks.asMap().entries
      .where((entry) => entry.value['platformName'] == target)
      .map((entry) => entry.key)
      .toList();
    for(int i=0;i<taskIndices.length;i++){
      tasks[taskIndices[i]]['platformName'] = newPlatformName;
    }
    platforms[index]['pName'] = newPlatformName;
    platforms[index]['uName'] = newUserName;
    platforms[index]['password'] = newPassword;
    notifyListeners();
  }
  void removeP(String target,int index){
    platforms.removeAt(index);
    List<int> taskIndices = tasks.asMap().entries
      .where((entry) => entry.value['platformName'] == target)
      .map((entry) => entry.key)
      .toList();
    print(taskIndices);
    for(int i=taskIndices.length-1;i>=0;i--){
      removeTask(taskIndices[i]);
    }
    notifyListeners();
  }
}