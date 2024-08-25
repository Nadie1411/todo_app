import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/app_colors.dart';

class LanguageBottomSheet extends StatefulWidget
{
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context)
  {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
     margin: EdgeInsets.all(15),
         child:
     Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.all(12.0),
           child: InkWell(
             onTap: () {
                 provider.changeAppLanguage("en");
             },
             child:provider.appLanguage == 'en'?
             getSelectedItemWidget(AppLocalizations.of(context)!.english) : getUnselectedItemWidget(AppLocalizations.of(context)!.english),
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(12.0),
           child: InkWell(
             onTap: () {
               provider.changeAppLanguage("ar");
             },
             child: provider.appLanguage == 'ar'?
             getSelectedItemWidget(AppLocalizations.of(context)!.arabic) : getUnselectedItemWidget(AppLocalizations.of(context)!.arabic),
           ),
         )

       ],
     ),
   );
  }

  Widget getSelectedItemWidget(String text)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primaryColor
  )
            ),
        Icon(Icons.check,size: 30, color: AppColors.primaryColor),
      ],
    );

  }
  Widget getUnselectedItemWidget(String text)
  {
    return Text(text,
        style:TextStyle(
            fontSize: 18,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w400
        ) );
  }
}