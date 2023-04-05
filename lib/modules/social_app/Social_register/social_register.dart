import 'package:Nouns_app/modules/social_app/Layout/layout_social_screen.dart';
import 'package:Nouns_app/shared/componets.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrumlab_colored_progress_indicators/scrumlab_colored_progress_indicators.dart';
import '../../../shared/styles/colours/colors.dart';
import 'cubit/Regester_Cubit.dart';
import 'cubit/Regester_states.dart';

class SocialRegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state) {
          if (state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(context,
                SocialLayout());
          }
        },
        builder: (context , state) {
          return Scaffold(
          appBar: AppBar(),
          body: Center(
          child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
          key: formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          'REGISTER', style: TextStyle(fontSize: 35),),
          SizedBox(
          height: 10,),
          Text('Register now to communicate with frindes', style:
          TextStyle(fontSize: 15,
          fontWeight: FontWeight.w200,
          color: (Colors.grey)),),
          SizedBox(height: 20,),
          TextFormField(
          controller: nameController,
          validator: (value) {
          if (value!.isEmpty) {
          return 'name must not be empty';
          }
          },
          keyboardType: TextInputType.name,

          decoration: InputDecoration(
          label: Text('User Name',
          style: TextStyle(color: Colors.grey),),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),

          ),
          ),
          SizedBox(height: 20,),
          TextFormField(
          controller: emailController,
          validator: (String? value) {
          if (value!.isEmpty) {
          return 'email must not be empty';
          }
          },
          keyboardType: TextInputType.emailAddress,

          decoration: InputDecoration(
          label: Text('Email addres',
          style: TextStyle(color: Colors.grey),),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email_outlined),

          ),
          ),
          SizedBox(height: 20,),
          // defaultFormText(
          //     control: passwordController,
          //     type: TextInputType.visiblePassword,
          //     validator: (String? value) {
          //       if(value!.isEmpty)
          //       {
          //           return 'add password';
          //         }
          //     },
          //     suffix: SocialRegisterCubit.get(context).suffix,
          //     onSubmit: ()
          //     {
          //
          //     },
          //     isPassword: SocialRegisterCubit.get(context).isPassword,
          //     label: 'password',
          //     prefix: Icons.lock_outline),
            TextFormField(
              controller: passwordController,
              validator: (value)
              {
                if (value!.isEmpty) {
                  return 'password must not be empty';
                }
              },
              keyboardType: TextInputType.visiblePassword,

              decoration: InputDecoration(
                label: Text('Password',
                  style: TextStyle(color: Colors.grey),),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outlined),

              ),
            ),
          SizedBox(height: 30,),
          TextFormField(
          controller: phoneController,
          validator: (value) {
          if (value!.isEmpty) {
          return 'phone number must not be empty';
          }
          },
          keyboardType: TextInputType.phone,

          decoration: InputDecoration(
          label: Text('Phone number',
          style: TextStyle(color: Colors.grey),),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.phone),

          ),
          ),
          SizedBox(
            height: 15,
          ),
          ConditionalBuilder(
          condition: state is! SocialRegisterLoadingState,
          builder: (context) => Container(
          width: double.infinity,
          color: defaultColor,
          child:
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: MaterialButton(
            onPressed: ()
            {
            if(formKey.currentState!.validate())
            {
              SocialRegisterCubit.get(context).userRegister(
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  phone: phoneController.text);
            }
            },
            child:
            Text('REGISTER',
            style: TextStyle(
            color: Colors.white),
            ),
            ),
          ),
          ),
          fallback: (context) => Center(
          child:ColoredCircularProgressIndicator()),
          ),
          ],
          ),
          ),
          ),
          ),
          ),
          );
        },
      ),
    );
  }
}
