class SocialUserModel {
  String? name;
  String? email;
  String? image;
  String? cover;
  String? bio;
  String? phone;
  String? uId;
  String? password;
  bool? isEmailVerified;

  SocialUserModel({
    this.email,
    this.image,
    this.cover,
    this.bio,
    this.name,
    this.phone,
    this.uId,
    this.password,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String,dynamic> json)
  {
    email = json['email'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap ()
  {
    return
      {
        'name' :name,
        'email' :email,
        'phone' :phone,
        'uId' :uId,
        'image' :image,
        'cover' :cover,
        'bio' :bio,
        'password' :password,
        'isEmailVerified':isEmailVerified,
      };
  }
}


