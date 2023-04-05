import 'package:Nouns_app/models/social_app/post_model.dart';
import 'package:Nouns_app/models/social_app/social_user_model.dart';
import 'package:Nouns_app/modules/social_app/cubit/cubit.dart';
import 'package:Nouns_app/modules/social_app/cubit/states.dart';
import 'package:Nouns_app/shared/styles/colours/colors.dart';
import 'package:Nouns_app/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).userModel != null && SocialCubit.get(context).posts.length > 0 ,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 20,
                    margin: EdgeInsets.all(6),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:[
                        Image(image:
                        NetworkImage('https://img.freepik.com/premium-vector/welcome-sign-modern-calligraphic-text-use-greeting-card-banner-template-postcard-welcome-back-hand-drawn-lettering_110464-748.jpg?w=1380'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 160,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('^Communicate With Friends^',
                            style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,wordSpacing: 4,),),
                        )

                      ],
                    )
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index] , context,index),
                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                    itemCount: SocialCubit.get(context).posts.length),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
Widget buildPostItem(PostModel model,context,index) => Card(
    clipBehavior: Clip.antiAlias,
    elevation: 20,
    margin: EdgeInsets.symmetric(
        horizontal: 8
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'),

              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${model.name}'
                          ,style: TextStyle(fontSize: 17),),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.check_circle,color: Colors.blue,
                          size: 15,),

                      ],
                    ),
                    Text('${model.dateTime}',
                      style: Theme.of(context).textTheme.caption, ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: ()
                  {

                  },
                  icon: Icon(IconBroken.More_Circle)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade300,
            ),
          ),
          Text(
            '${model.text}',
            style: TextStyle(
                fontSize:18
            ),),
          SizedBox(
            height: 15,
          ),
          if(model.postImage != '')
          Container(
            child: Image(image:
            NetworkImage('${model.postImage}'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 140,),

          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 20,),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}'
                              ,style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600
                            ),
                            )
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                              size: 20,),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0'
                              ,style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600
                            ),
                            )
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade300,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            '${model.image}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Write a comment...',
                        style: Theme.of(context).textTheme.caption,)
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                      size: 15 ,),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like'
                      ,style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600
                    ),
                    )
                  ],
                ),
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              ),
            ],
          )
        ],
      ),
    )
);