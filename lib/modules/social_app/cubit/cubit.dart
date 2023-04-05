import 'dart:io';

import 'package:Nouns_app/models/social_app/massage_model.dart';
import 'package:Nouns_app/models/social_app/social_user_model.dart';
import 'package:Nouns_app/models/user_model.dart';
import 'package:Nouns_app/modules/social_app/chats/chats_screen.dart';
import 'package:Nouns_app/modules/social_app/cubit/states.dart';
import 'package:Nouns_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:Nouns_app/modules/social_app/profile/profile_screen.dart';
import 'package:Nouns_app/modules/social_app/users/useers_screen.dart';
import 'package:Nouns_app/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/social_app/post_model.dart';
import '../../../shared/constants.dart';
import '../new_post/new_post_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    })
        .catchError((error)
    {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens =
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    FriendsScreen(),
    ProfileScreen(),
  ];

  List<String> titles =
      [
        'Home',
        'Chats',
        'Add Post',
        'Friends',
        'Profile'
      ];

  void changBottomNav(int index)
  {
    if(index == 1)
      getUsers();
    if(index == 2)
      emit(SocialNewPostState());
    else
      {
        currentIndex = index;
        emit(SocialChangeBottomNavState());
      }
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile  = await picker.pickImage(
        source: ImageSource.gallery);

    if (pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else
    {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }

  }

  File? coverImage;
  Future<void> getCoverImage() async
  {
    final pickedFile  = await picker.pickImage(
        source: ImageSource.gallery);

    if (pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else
    {
      print('No Image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage(
  {
    required String name,
    required String bio,
    required String phone,
    required String password,
  }
      )
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value)
          {
            // emit(SocialUploadProfileImageSuccessState());
            print(value);
            updateUser(
                name: name,
                bio: bio,
                phone: phone,
                password: password,
                image: value);

          }).catchError((error)
          {
            emit(SocialUploadProfileImageErrorState());
          });
    }).catchError((error)
    {
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void uploadCoverImage(
{
  required String name,
  required String bio,
  required String phone,
  required String password,
})
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value)
          {
            // emit(SocialUploadCoverImageSuccessState());
            print(value);
            updateUser(
                name: name,
                bio: bio,
                phone: phone,
                password: password,
                cover: value);

          }).catchError((error)
          {
            emit(SocialUploadCoverImageErrorState());
          });
    }).catchError((error)
    {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser ({
    required String name,
    required String bio,
    required String phone,
    required String password,
    String ? image,
    String ? cover,
  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      isEmailVerified: false,
      password: password,
      uId: userModel!.uId!,
      email: userModel!.email!,
      cover: cover??userModel!.cover!,
      image: image??userModel!.image!,
    );

    FirebaseFirestore.instance.
    collection('users')
        .doc(userModel!.uId!)
        .update(model.toMap())
        .then((value)
    {
      getUserData();
    })
        .catchError((error)
    {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;
  Future<void> getPostImage() async
  {
    final pickedFile  = await picker.pickImage(
        source: ImageSource.gallery);

    if (pickedFile != null)
    {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else
    {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage(
      {
        required String dateTime,
        required String text,

      })
      {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
            text: text,
            dateTime: dateTime,
            postImage: value);
      }).catchError((error)
      {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost ({
    required String dateTime,
    required String text,
    String? postImage,

  })
  {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId!,
      image: userModel!.image!,
      dateTime: dateTime,
      postImage: postImage??'',
      text: text,
    );

    FirebaseFirestore.instance.
    collection('posts')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialCreatePostSuccessState());
    })
        .catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts =[];
  List<String> postsId =[];
  List<int>likes =[];

  void getPosts()
  {
   FirebaseFirestore.instance
       .collection('posts')
       .get()
       .then((value)
   {
     value.docs.forEach((element)
     {
     element.reference
     .collection('likes')
     .get()
     .then((value)
     {
       likes.add(value.docs.length);
       postsId.add(element.id);
       posts.add(PostModel.fromJson(element.data()));
     })
     .catchError((error) {});
     });
     emit(SocialGetPostSuccessState());
   }).catchError((error)
   {
     emit(SocialGetPostErrorState(error.toString()));
   });
  }


  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc('postId')
        .collection('likes')
        .doc(userModel!.uId!)
        .set({
      'like' : true,
             }).then((value)
    {
      emit(SocialLikePostSuccessState());
    }).catchError((error)
    {
      emit(SocialLikePostErrorState());
    });
  }

    List<SocialUserModel> users = [];

  void getUsers()
  {
    FirebaseFirestore.instance.collection('users').get().then((value)
    {
      if(users.length == 0)
      value.docs.forEach((element)
      {
        if(element.data()['uId'] != userModel!.uId)
        users.add(SocialUserModel.fromJson(element.data()));
      });

      emit(SocialGetAllUsersSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  void sendMessage(
  {
    required String receiverId,
    required String dateTime,
    required String text,
    String ? messageImage,
  })
  {
    MessageModel  model = MessageModel
      (
      text: text ,
      senderId: userModel!.uId!,
      receiverId: receiverId,
      dateTime: dateTime,
      messageImage: messageImage ?? '',
    );
    //set my chat

    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId!)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value)
    {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

    //set receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId!)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialGetMessageSuccessState());
    })
        .catchError((error)
    {
      emit(SocialGetMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages(
  {
    required String ? receiverId,
}
      )
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];

      event.docs.forEach((element)
      {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

//   File? messageImage;
//   var pickerImageMessage = ImagePicker();
//
//   Future<void> getMessageImage()
//   async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       messageImage = File(pickedFile.path);
//       emit(SocialMessageImagePickedSuccessState());
//     } else {
//       print('No image selected.');
//       emit(SocialMessageImagePickedErrorState());
//     }
//   }



  // Future uploadMessageImage({
  //   required String receiverId,
  //   required String datetime,
  //   required String text,
  // }) async {
  //   emit(SocialCreateMessageImageLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('messages/${Uri.file(messageImage!.path).pathSegments.last}')
  //       .putFile(messageImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       sendMessage(
  //           dateTime: datetime,
  //           text: text,
  //           messageImage: value,
  //           receiverId: receiverId);
  //       print(messageImage);
  //     }).catchError((error) {
  //       emit(SocialCreateMessageImageErrorState());
  //     });
  //   }).catchError((error) {
  //     emit(SocialCreateMessageImageErrorState());
  //   });
  // }

  File? messageImageFile;
  Future getMessageImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile !=null){
      messageImageFile=File(pickedFile.path);
      print(messageImageFile.toString());

      emit(SocialMessageImagePickedSuccessState());
    }else
    {
      print('No Image Selected');
      emit(SocialMessageImagePickedErrorState());}
  }

  void uploadMessageImage({
    required String dateTime,
    required String text,
    required String receiverId,
  })
  {
    emit(SocialCreateMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance.ref()
        .child('users${userModel!.uId}Chats$receiverId/Messages/${Uri.file(messageImageFile!.path).pathSegments.last}')
        .putFile(messageImageFile!).then((value)  {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
            receiverId: receiverId,
            text: text,
            dateTime: dateTime,
            messageImage: value
        );

      }).catchError((error){
        emit(SocialCreateMessageImageErrorState());
      });

    }).catchError((error){
      emit(SocialCreateMessageImageErrorState());
    });
    // firebase_storage.FirebaseStorage.instance.ref()
    //     .child('users$receiverId/Chats${userModel!.uid}/Messages/${Uri.file(messageImageFile!.path).pathSegments.last}')
    //     .putFile(messageImageFile!).then((value)  {
    //   value.ref.getDownloadURL().then((value) {
    //     print(value);
    //     sendMessage(
    //         receiverId: userModel!.uid!,
    //         chatText: text,
    //         dataTime: dateTime,
    //         image: value
    //     );
    //     emit(SocialCreateChatUsersSuccessState());
    //     print(value.toString()+' this is image');
    //   }).catchError((error){
    //     emit(SocialMessageImageErrorState());
    //   });
    //
    // }).catchError((error){
    //   emit(SocialMessageImageErrorState());
    // });
  }
  void removeMessageImage(){
    messageImageFile=null;
    emit(SocialRemovePostImageState());
  }






}



