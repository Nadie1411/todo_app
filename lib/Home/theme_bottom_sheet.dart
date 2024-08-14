import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_config_provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget
{
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
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
               provider.changeMode(ThemeMode.light);
             },
             child: provider.appMode == ThemeMode.light?
             getSelectedItemWidget(AppLocalizations.of(context)!.light)
                 : getUnselectedItemWidget(AppLocalizations.of(context)!.light)
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(12.0),
           child: InkWell(
             onTap: () {
               provider.changeMode(ThemeMode.dark);
             },
             child: provider.appMode == ThemeMode.dark?
                 getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                 : getUnselectedItemWidget(AppLocalizations.of(context)!.dark)
               
               
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