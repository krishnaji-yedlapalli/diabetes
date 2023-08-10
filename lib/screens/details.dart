import 'package:diabetes_tracker/models/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final RelatedTopics relatedDetails;
  final bool isLandscape;
  const DetailsScreen({Key? key, required this.relatedDetails, required this.isLandscape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLandscape ? null : AppBar(title: Text('Related Topic Details')),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header('Image'),
              Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.network(imageUrl)),
              _header('Title'),
              Text('${relatedDetails.title}'),
              _header('Description'),
              Text('${relatedDetails.text}'),
            ],
          ),
        ),
      ),
    );
  }

  String get imageUrl => relatedDetails.iconModel!.iconUrl.isEmpty
      ? 'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg'
      : 'https://duckduckgo.com/${relatedDetails.iconModel?.iconUrl}';

  Widget _header(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text('$text : ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      );
}
