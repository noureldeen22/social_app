import 'package:Nouns_app/models/social_app/social_user_model.dart';
import 'package:Nouns_app/modules/social_app/chat_details/chat_detlies_screen.dart';
import 'package:Nouns_app/modules/social_app/cubit/cubit.dart';
import 'package:Nouns_app/modules/social_app/cubit/states.dart';
import 'package:Nouns_app/shared/componets.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
         return ConditionalBuilder(
             condition: SocialCubit.get(context).users.length > 0,
             builder: (context) => ListView.separated(
                 physics: BouncingScrollPhysics(),
                 itemBuilder: (context,index)=> BuildChatItem(SocialCubit.get(context).users[index],context),
                 separatorBuilder: (context,index)=> myDivider(),
                 itemCount: SocialCubit.get(context).users.length),
             fallback:(context) => Center(child: CircularProgressIndicator()));
        },
        );
  }
}
Widget BuildChatItem(SocialUserModel model,context) => InkWell(
  onTap: ()
  {
    navigateTo( context, ChatDetailsScreen(
      userModel: model,));
  },
  child:   Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

  crossAxisAlignment: CrossAxisAlignment.start,

  children: [

  CircleAvatar(

  radius: 25,

  backgroundImage: NetworkImage(

  '${model.image}'),

  ),

  SizedBox(

  width: 2,

  ),

  Column(

  crossAxisAlignment: CrossAxisAlignment.start,

  children: [

  Padding(

  padding: const EdgeInsets.all(13.0),

  child: Row(

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

  ),

  ],

  ),

  ],

  ),

  ),
);