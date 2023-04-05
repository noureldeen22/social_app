import 'package:Nouns_app/modules/social_app/cubit/cubit.dart';
import 'package:Nouns_app/modules/social_app/cubit/states.dart';
import 'package:Nouns_app/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:Nouns_app/shared/componets.dart';
import 'package:Nouns_app/shared/styles/icon_broken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var userModel = SocialCubit.get(context).userModel;

       return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 180,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                   '${userModel!.cover }'
                                ),
                                fit: BoxFit.cover)
                        ),

                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 57,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                            "${userModel.image}"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${userModel.name}",
                style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(
                height: 10,
              ),
              Text("${userModel.bio}",
                style: Theme.of(context).textTheme.caption,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('48',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Posts',
                              style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('59',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Photos',
                              style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('3k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Followers',
                              style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('863',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Following',
                              style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child:OutlinedButton(
                        onPressed: (){},
                        child: Text('Add Photos')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: ()
                      {
                        navigateTo(context,EditProfileScreen());
                      },
                      child: Icon(
                          IconBroken.Edit,
                      size: 20,))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed:
                        ()
                        {
                          FirebaseMessaging.instance.subscribeToTopic('announcments');
                          showToast(text: 'Subscribe', state: ToastStates.SUCCESS);
                        },
                        child: Text('Subscribe')),
                  ),
                  SizedBox(
                    width:5
                  ),
                  Expanded(
                    child: OutlinedButton(
                        onPressed:
                        ()
                        {
                          FirebaseMessaging.instance.unsubscribeFromTopic('unannouncments');
                          showToast(text: 'UnSubscribe', state: ToastStates.ERROR);
                        },
                        child: Text('Unsubscribe')),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
