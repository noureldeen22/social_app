import 'dart:io';

import 'package:Nouns_app/modules/social_app/cubit/cubit.dart';
import 'package:Nouns_app/modules/social_app/cubit/states.dart';
import 'package:Nouns_app/shared/componets.dart';
import 'package:Nouns_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        passwordController.text = userModel.password!;

         return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            leading: IconButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2)),
            actions: [
              TextButton(
                  onPressed: ()
                  {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                        password: passwordController.text,
                    );
                  },
                  child: Text('UPDATE',
                    style: TextStyle(fontSize: 14),)),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6)
                                    ),
                                    image: DecorationImage(
                                        image: coverImage == null ? NetworkImage(
                                            '${userModel.cover }'
                                        ) : FileImage(coverImage) as ImageProvider,
                                        fit: BoxFit.cover)
                                ),

                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context).canvasColor,
                                      child: IconButton(
                                      onPressed: ()
                                      {
                                        SocialCubit.get(context).getCoverImage();
                                      },
                                      icon: Icon(IconBroken.Camera)),
                                ),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 57,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                profileImage == null ? NetworkImage(
                                    "${userModel.image}") : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                              radius: 17,
                              backgroundColor: Theme.of(context).canvasColor,
                              child: IconButton(
                                iconSize: 17,
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(IconBroken.Camera,)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            MaterialButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text);
                                },
                              color: Colors.blue,
                              child: Text('upload profile',
                              style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                            if (state is SocialUserUpdateLoadingState)
                            SizedBox(
                              height: 5,
                            ),
                            if (state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            MaterialButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text);
                                },
                              color: Colors.blue,
                              child: Text('Upload Cover',
                              style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                            if (state is SocialUserUpdateLoadingState)
                            SizedBox(
                              height: 5,
                            ),
                            if (state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (String? value)
                    {
                      if(value!.isEmpty)
                              {
                                return 'name must not be empty';
                              }
                            else
                            {
                              return null;
                            }
                    },
                    decoration: InputDecoration(
                      label: Text('name'),
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    validator: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      else
                      {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('bio'),
                      prefixIcon: Icon(IconBroken.Info_Circle),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.text,
                    validator: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      else
                      {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('phone'),
                      prefixIcon: Icon(IconBroken.Call),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                   validator: (String? value)
                   {
                    if(value!.isEmpty)
                  {
                    return 'password must not be empty';
                  }
                   else
                  {
                   return null;
                  }
                  },
                   decoration: InputDecoration(
                   label: Text('password'),
                   prefixIcon: Icon(IconBroken.Password),
                   border: OutlineInputBorder(),
                  ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
