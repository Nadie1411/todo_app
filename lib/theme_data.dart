
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/app_colors.dart';

class MyTheme
{
  static const String routeName =  'login' ;

  //Light Mode
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
      elevation: 0,
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryColor,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      )
    ) ,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          shape: StadiumBorder(
              side: BorderSide(color: AppColors.whiteColor, width: 6
                  //RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(35),
                  //side: BorderSide(
                  //color: AppColors.whiteColor,
                  //width: 8

                  ))),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor),
          bodySmall: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor)
      ),


  );


  //Dark Theme
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundDarkColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryColor,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        elevation: 0
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          shape: StadiumBorder(
              side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 6
                //RoundedRectangleBorder(
                //borderRadius: BorderRadius.circular(35),
                //side: BorderSide(
                //color: AppColors.whiteColor,
                //width: 8

              )

          )

      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            color: AppColors.whiteColor),
        bodyMedium: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            color: AppColors.whiteColor),
          bodySmall: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor))

  );
}