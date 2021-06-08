import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/category.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/widget/widget.dart';
import 'package:wallpaper_app/model/category_model.dart';
import "package:http/http.dart " as http;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int noOfImageToLoad = 30;
  List<CategoriesModel> categories=new List();
  List<WallpaperModel> wallpapers=new List();
  TextEditingController searchController=new TextEditingController();

  getTrendingWallpapers() async{
    http.Response response=await http.get("https://api.pexels.com/v1/curated?per_page=80&page=1",headers: {
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
    getTrendingWallpapers();
    categories=getCategories();
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
        child: Container(child:Column(
          children: [
            SizedBox(height:6.0),
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
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>Search(searchQuery: searchController.text,) ));
                    },
                        child: Icon(Icons.search))
                  ],
                ),
              ),
            SizedBox(height:16),
            Container(
              height:80,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:categories.length,
                  itemBuilder:(context,index){
                  //wallpapers[index].src.portrait;
                    return CategoryTile(
                      title:categories[index].categoriesName,
                      imgUrl: categories[index].imgUrl,
                    );
                  }),
            ),
            SizedBox(height: 16,),
            wallpapersList(wallpapers: wallpapers,context: context)
            ]


        )

          ),
      )
      );

  }
}
class CategoryTile extends StatelessWidget {
  final String imgUrl,title;
  CategoryTile({@required this.title,@required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Category(categoryName: title.toLowerCase(),)));
      } ,
      child: Container(
        margin: EdgeInsets.only(right:4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius:BorderRadius.circular(8),
                child: Image.network(imgUrl,height:50,width:100,fit:BoxFit.cover)),

            Container(
              decoration: BoxDecoration(
                  color:Colors.black26,
                borderRadius: BorderRadius.circular(8)
              ),
            height:50,
              width:100,
            alignment:Alignment.center,

              child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 16),),
            )
          ],
        ),
      ),
    );
  }
}

