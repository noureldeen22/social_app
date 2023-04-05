 import 'package:Nouns_app/modules/social_app/cubit/cubit.dart';
import 'package:Nouns_app/modules/social_app/cubit/states.dart';
import 'package:Nouns_app/modules/social_app/new_post/new_post_screen.dart';
import 'package:Nouns_app/shared/componets.dart';
import 'package:Nouns_app/shared/styles/icon_broken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state)
        {
          if(state is SocialNewPostState)
          {
          navigateTo(context, NewPostScreen());
        }
      },
        builder: (context,state)
    {
      var cubit = SocialCubit.get(context);

      return Scaffold(
        appBar: AppBar(
         title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(
                onPressed: (){},
                icon: Icon(IconBroken.Notification)),
            IconButton(
                onPressed: (){},
                 icon: Icon(IconBroken.Search)),
          ],
         ),
          body: cubit.Screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index)
          {
            cubit.changBottomNav(index);
          },
          items:
          [
            BottomNavigationBarItem(icon: Icon(
              IconBroken.Home,
            ),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(
              IconBroken.Chat,
            ),label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(
              IconBroken.Upload,
            ),label: 'Post'),
            BottomNavigationBarItem(icon: Icon(
              IconBroken.User,
            ),label: 'Uses'),
            BottomNavigationBarItem(icon: Icon(
              IconBroken.Setting,
            ),label: 'Settings'),
          ],
        ),
    );
    },
    );
  }
}
