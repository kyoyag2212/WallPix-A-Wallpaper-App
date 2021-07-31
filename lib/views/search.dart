import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widget/widget.dart';
import "package:http/http.dart " as http;
class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController=new TextEditingController();
  List<WallpaperModel> wallpapers=new List();
//function for getting search wallpaper
  getSearchWallpapers(String query) async{
    var response=await http.get("https://api.pexels.com/v1/search?query=$query&per_page=80",headers: {
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
    getSearchWallpapers(widget.searchQuery);
    searchController.text=widget.searchQuery;

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
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:searchController,
                        decoration: InputDecoration(
                            hintText: "search wallpaper",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    GestureDetector(onTap: (){
                      getSearchWallpapers(searchController.text);


                    },
                        child: Icon(Icons.search))
                  ],
                ),
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
