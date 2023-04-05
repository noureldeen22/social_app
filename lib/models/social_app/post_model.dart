class PostModel {
  String? name;
  String? image;
  String? uId;
  String? text;
  String? dateTime;
  String? postImage;

  PostModel({
    this.image,
    this.postImage,
    this.name,
    this.text,
    this.uId,
    this.dateTime,
  });

  PostModel.fromJson(Map<String,dynamic> json)
  {
    image = json['image'];
    postImage = json['postImage'];
    text = json['text'];
    name = json['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
  }

  Map<String,dynamic> toMap ()
  {
    return
      {
        'name' :name,
        'image' :image,
        'postImage' :postImage,
        'text' :text,
        'dateTime' :dateTime,
        'uId':uId,
      };
  }
}


