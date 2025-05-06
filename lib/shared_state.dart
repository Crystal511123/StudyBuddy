import 'package:flutter/material.dart';

class SharedState extends ChangeNotifier {
   
  List<Map<String, dynamic>> tasks = [
    {
      'area': 'Forest',
      'title': 'Business English',
      'reward': 'Exp 200',
      'task': 'Finish Module 1',
      'progress': '30:34 / 30:34',
      'progressValue': 1.0,
      'link':'coursera.org/learn/Business-English',
      'access':'0123456789',
      'hours':1,
      'minutes': 30,
      'period':'Day',

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
  void updateCourseInfo(int index, String newCourseName, String newCourseLink, String newCourseAccess, int newCourseHours,int newCourseMinutes, String newCoursePeriod) {
    tasks[index]['title'] = newCourseName; // Update the course name
    tasks[index]['link'] = newCourseLink; // Update the course name
    tasks[index]['access'] = newCourseAccess; 
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
    exp+=200;
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
    notifyListeners(); // Notify listeners about the change
  }
  String landName(String name) {
    if(name=='Forest') {return 'Forest';}
    else {return recordName;}// Update the course name // Notify listeners about the change
  }
}