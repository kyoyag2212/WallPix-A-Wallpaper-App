import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart " as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widget/widget.dart';
class Category extends StatefulWidget {
  final String categoryName;
  Category({this.categoryName});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallpaperModel> wallpapers=new List();



  getSearchWallpapers(String query) async{
    var response=await http.get("https://api.pexels.com/v1/search?query=$query&per_page=15",headers: {
      "Authorization": api_key});
    //print(response.body.toString());
    Map<String,dynamic> jsonData=jsonDecode(response.body);
    jsonData['photos'].forEach((element){
      //print(element);
      WallpaperModel wallpaperModel=new WallpaperModel();
      wallpaperModel=WallpaperModel.fromMap(element);
     wallpapers.add(wallpaperModel);

    });
    setState(() {

    });
  }
  @override
  void initState() {
    getSearchWallpapers(widget.categoryName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.grey[900],
        appBar: AppBar(
          title: brandName(),
          elevation: 0.0,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)
              )
          ),
        ),
        body:SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.symmetric(horizontal:24),
                  margin: EdgeInsets.symmetric(horizontal:24),

                ),
                SizedBox(height: 16,),
                wallpapersList(wallpapers: wallpapers,context: context)

              ],
            ),
          ),
        )
    );
  }
}
