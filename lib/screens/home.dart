
import 'dart:io';

import 'package:diabetes_tracker/models/home_model.dart';
import 'package:diabetes_tracker/providers/home_prov.dart';
import 'package:diabetes_tracker/variants/variants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    context.read<HomeProvider>().loadHomeDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('The ${isWire ? 'Wire' : 'Simpsons'} Characters View')),
        body: _buildStreamBuilder);
  }

  Widget get _buildStreamBuilder {
    return StreamBuilder(
        stream: context.read<HomeProvider>().streamCtrl.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildMain(snapshot.data as HomeDetailsModel);
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              default:
                return Container();
            }
          }
        });
  }

  Widget _buildMain(HomeDetailsModel homeDetails) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          var isLandscape = MediaQuery
              .of(context)
              .size
              .shortestSide > 600 || orientation == Orientation.landscape
              ? true
              : false;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSearch(isLandscape),
                Expanded(
                    child: Consumer<HomeProvider>(
                        builder: (context, provider, child) {
                          return isLandscape
                              ? _buildTabOrLandscapeView(
                              provider.relatedTopicsList, isLandscape)
                              : _buildMobilePotraitView(
                              provider.relatedTopicsList, isLandscape);
                        })),
              ]);
        }
    );
  }


  Widget _buildMobilePotraitView(List<RelatedTopics> topics, bool isLandscape) {
    return ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          var topic = topics[index];
          return Visibility(
            visible: topic.show,
            child: InkWell(
              onTap: () => isLandscape ? context.read<HomeProvider>().setTopicIndex = index : onTapOfList.call(topic, isLandscape),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                color: Colors.green,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
                    child: Text('${index + 1}.  ${topic.title}',
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white))),
              ),
            ),
          );
        }
    );
  }


  Widget _buildTabOrLandscapeView(List<RelatedTopics> topics, bool isLandscape) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: _buildMobilePotraitView(topics, isLandscape)),
        Expanded(
            flex: 1,
            child: DetailsScreen(relatedDetails: topics.elementAt(context.watch<HomeProvider>().selectedTopicIndex), isLandscape: isLandscape)),
      ],
    );
  }

  void onTapOfList(RelatedTopics topic, bool isLandscape ) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                DetailsScreen(relatedDetails: topic, isLandscape : isLandscape)));
  }

  Widget buildSearch(bool isLandscape) {
    var prov = context.read<HomeProvider>();
    return Container(
      height: 45,
      width: isLandscape ? MediaQuery.of(context).size.width/1.5 : MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextField(
        controller: prov.searchCtrl,
        onChanged: prov.onSearch,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.search),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: _border,
            fillColor: Colors.blue.withOpacity(0.05),
            enabledBorder: _border,
            focusedBorder: _border),
      ),
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(15)));

  bool get isWire => VariantTypes.wire == Variant().varConfig?.variantType;
}
