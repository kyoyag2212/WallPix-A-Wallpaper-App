class WallpaperModel{
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;
  WallpaperModel({this.src,this.photographer,this.photographer_id,this.photographer_url});
  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
    return WallpaperModel(
      src:SrcModel.fromMap( jsonData["src"]),
      photographer_url: jsonData["photographer_url"],
      photographer_id:jsonData["photographer_id"],
      photographer: jsonData["photographer"]
    );
  }
}
class SrcModel{
  SrcModel({this.original,this.portrait,this.small});
  String original;
  String small;
  String portrait;
  factory SrcModel.fromMap(Map<String,dynamic> jsonData){
    return SrcModel(
      portrait: jsonData['portrait'],
      original: jsonData['original'],
      small:  jsonData['small']
    );
  }
}