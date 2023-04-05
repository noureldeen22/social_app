import 'package:Nouns_app/modules/social_app/cubit/cubit.dart';
import 'package:Nouns_app/modules/social_app/cubit/states.dart';
import 'package:Nouns_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_time_format/date_time_format.dart';

class NewPostScreen extends StatelessWidget
{
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit, SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Post',style: TextStyle(color: Colors.black),),
            leading: IconButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2,color: Colors.black,)),
            actions: [
              TextButton(
                  onPressed: ()
                  {
                     var now = DateTime.now();


                    if(SocialCubit.get(context).postImage == null)
                      {
                        SocialCubit.get(context).createPost(
                            dateTime: DateTimeFormat.format(now,format: DateTimeFormats.american),
                            text: textController.text);
                      }else
                        SocialCubit.get(context).uploadPostImage(dateTime:
                        DateTimeFormat.format(now,format: DateTimeFormats.american),
                        text: textController.text);
                        },
                  child: Text('Post',
                    style: TextStyle(fontSize: 19),))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                     '${SocialCubit.get(context).userModel!.image}'
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
              child: Text(
                'Nour El-deen',
                style: TextStyle(
                  height: 1.4,
                ),
              ),
            ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if ( SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
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
                              SocialCubit.get(context).removePostImage();
                            },
                            icon: Icon(IconBroken.Close_Square)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('add photo')
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                          child: Text('# tags')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
