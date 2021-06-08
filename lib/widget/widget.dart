import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';
 Widget brandName(){
   return RichText(
     text: TextSpan(
       children: <TextSpan>[
         TextSpan(text: 'Wall', style: TextStyle(color: Colors.grey[50], fontSize: 20.0,letterSpacing: 2.0)),
         TextSpan(text: 'Pix', style: TextStyle(color: Colors.blueAccent,fontSize: 20.0,letterSpacing: 2.0),),
       ],
     ),
   );
 }
//
//
 Widget wallpapersList({List<WallpaperModel> wallpapers,context}){
   return Container(

     child:GridView.count(
       crossAxisCount: 2,
       childAspectRatio: 0.6,
       mainAxisSpacing: 6.0,  
       crossAxisSpacing: 6.0,
       shrinkWrap: true,
       physics: ClampingScrollPhysics(),
       padding: EdgeInsets.symmetric(horizontal: 16),

   children:wallpapers.map((wallpaper) {
     return GridTile(
     child:GestureDetector(
       onTap: (){
         Navigator.push(context, MaterialPageRoute(builder:(context)=>ImageView(imgUrl:wallpaper.src.portrait,) ));
       },
       child: Hero(
         tag:wallpaper.src.portrait,
         child: Container(
         child:ClipRRect(borderRadius:BorderRadius.circular(16),child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover)),
         ),
       ),
     ),
   );
   }).toList(),
   ),
   );
 }