import 'package:Nouns_app/modules/social_app/Layout/layout_social_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrumlab_colored_progress_indicators/scrumlab_colored_progress_indicators.dart';
import '../../../network/local/cahce_helper.dart';
import '../../../shared/componets.dart';
import '../../../shared/styles/colours/colors.dart';
import '../Social_register/social_register.dart';
import 'cubit/Cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context ) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state)
        {
          if(state is SocialLoginErrorState)
            {
              showToast(text: state.error,
                  state:ToastStates.ERROR);
            }
          if(state is SocialLoginSuccessState)
            {
              CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId
              ).then((value)
              {
                navigateTo(
                    context,
                    SocialLayout());
              });
            }
        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
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
                          'LOGIN', style: TextStyle(fontSize: 35),),
                        SizedBox(
                          height: 10,),
                        Text('Login now to communicate with frindes',
                          style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: (Colors.grey)),),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
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
                        TextFormField(
                          onFieldSubmitted: (value)
                          {
                            navigateAndFinish(context,SocialLoginScreen());
                            if(formKey.currentState!.validate())
                            {
                              // ShopLoginCubit.get(context).userLogin(
                              //     email: emailController.text,
                              //     password: passwordController.text
                              // );
                            }
                          },
                          obscureText: SocialLoginCubit.get(context).isPassword,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              label: Text('Password',
                                style: TextStyle(color: Colors.grey),),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon:IconButton(
                                  onPressed: ()
                                  {
                                    SocialLoginCubit.get(context).changePasswordVisibility();
                                  },
                                  icon: Icon( SocialLoginCubit.get(context).suffix ))
                          ),
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
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
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child:
                                Text('LOGIN',
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) => Center(
                              child:ColoredCircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have account?',
                            ),
                            TextButton(onPressed: () {
                              navigateTo(context, SocialRegisterScreen());
                            },
                              child: Text(
                                'REGISTER NOW',
                                style: TextStyle(
                                    fontWeight: FontWeight.w100, fontSize: 13),

                              ),),

                          ],
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
