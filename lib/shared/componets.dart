import 'package:Nouns_app/shared/styles/colours/colors.dart';
import 'package:Nouns_app/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget myDivider () =>  Padding(
  padding:const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[300],
  ),);

void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(
    builder:(context) => widget,
    ),
);

void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute( builder:(context) => widget,
    ), (route) {
  return false;
});

void showToast(
{
  required String text,
  required ToastStates state,
}) =>  Fluttertoast.showToast(
msg:text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
    color = Colors.green;
    break;
    case ToastStates.ERROR:
    color =Colors.red;
    break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}

Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String? label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) => TextFormField(
  controller: control,
  keyboardType: type,
  validator: validator,
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onTap: () {},
  obscureText: isPassword,
  onChanged: (value) {
    onChanged!(value);
  },
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: () {
          suffixClicked!();
        },
        icon: Icon(suffix),
      )
          : null,
      border: OutlineInputBorder()),
);

Widget defaultButton({
  double width = double.infinity,
  Color backGroundColor = defaultColor,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() onTap,
  required String text,
}) => Container(
    width: width,
    height: 40,
    decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(radius)),
    child: MaterialButton(
      onPressed: onTap,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
            fontSize: 18, color: Colors.white, ),
      ),
    ));

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      icon:Icon(
          IconBroken.Arrow___Left_Circle )),

       title: Text(
         title!),
       actions: actions,
);


