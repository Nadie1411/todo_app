import 'package:flutter/material.dart';
import 'package:todo_app/Home/language_bottom_sheet.dart';
import 'package:todo_app/Home/theme_bottom_sheet.dart';
import 'package:todo_app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Container(


      margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.language,
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 22,)),
            SizedBox(height: height*0.02),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2

                )


              ),
              child: InkWell(
                onTap:(){
                  showLanguageBottomSheet();
                } ,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.english,
                    style: TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 22)),
                    Icon(Icons.arrow_drop_down)


                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.03,),
            Text(AppLocalizations.of(context)!.mode,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),),
            SizedBox(height: height*0.02),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: AppColors.primaryColor,
                      width: 2

                  )


              ),
              child: InkWell(
                onTap: (){
                  showThemeBottomSheet();

                },
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.light,
                        style: TextStyle(fontWeight: FontWeight.w400,
                            fontSize: 22)),
                    Icon(Icons.arrow_drop_down)


                  ],
                ),
              ),
            ),

          ],
        ),
    );
  }
  void showThemeBottomSheet()
  {
    showModalBottomSheet(
        context: context,
        builder: (context)=> ThemeBottomSheet());
  }

  void showLanguageBottomSheet()
  {
    showModalBottomSheet(
        context: context,
        builder: (context)=> LanguageBottomSheet());
  }

}

