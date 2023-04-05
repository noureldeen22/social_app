
import 'package:Nouns_app/modules/social_app/Layout/layout_social_screen.dart';
import 'package:Nouns_app/modules/social_app/cubit/cubit.dart';
import 'package:Nouns_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:Nouns_app/network/remote/dio_helper.dart';
import 'package:Nouns_app/shared/constants.dart';
import 'package:Nouns_app/shared/cubit/states.dart';
import 'package:Nouns_app/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'network/local/cahce_helper.dart';
import 'shared/bloc_observer.dart';
import 'shared/componets.dart';
import 'shared/cubit/cubit.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());

  showToast(text: 'on background message', state: ToastStates.SUCCESS,);
}

void main() async
{
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();

  print(token);


  // foreground fcm
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());

    showToast(text: 'on message', state: ToastStates.SUCCESS,);
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  uId = CacheHelper.getData(key: 'uId');


  if(uId != null)
  {
    widget = SocialLayout();
  } else
  {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ThemeCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: SocialLoginScreen(),
          );
        },
      ),
    );
  }
}

// ./gradlew signingReport