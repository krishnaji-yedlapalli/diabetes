import 'dart:async';
import 'package:diabetes_tracker/models/home_model.dart';
import 'package:flutter/material.dart';
import '../repository/home_repo.dart';
import '../utils/helper_methods.dart';

class HomeProvider with ChangeNotifier {

  List<RelatedTopics> relatedTopicsList = [];

  var searchCtrl = TextEditingController();

  int selectedTopicIndex = 0;

  StreamController streamCtrl = StreamController.broadcast();

  dispose() {
    streamCtrl.close();
    super.dispose();
  }

  loadHomeDetails(BuildContext context) async {
    try {
      var response = await HomeRepository().getData();
      if (response != null) {
        relatedTopicsList = response.relatedTopicsList;
        response.relatedTopicsList.forEach((element) {
         var splitList =  element.text.split('-');
         element.title = splitList[0].trim();
        });
      }
      streamCtrl.sink.add(response);
    } catch (e, s) {
      HelperMethods.showSnackBarMessage(context, '${e.toString()}');
    }
  }

  void onSearch(String val) {
    if (relatedTopicsList.isEmpty) return;

    relatedTopicsList.forEach((e) {
      if (val.trim().isNotEmpty &&
          e.title.toLowerCase().contains(val.toLowerCase())) {
        e.show = true;
      } else if (val.trim().isEmpty) {
        e.show = true;
      } else {
        e.show = false;
      }
    });
   notifyListeners();
  }

  set setTopicIndex(int index) {
    selectedTopicIndex = index;
    notifyListeners();
  }
}
