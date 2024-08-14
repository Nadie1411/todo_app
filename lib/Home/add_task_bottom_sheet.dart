import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatelessWidget {
String title='';
String description='';
var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(12),
      child: Column(

       children: [
         Text(AppLocalizations.of(context)!.add,
         style:TextStyle(fontSize: 19,
             fontWeight: FontWeight.bold,
         color: AppColors.blackColor) ,),
         Form(
             key:formKey,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),

               child: TextFormField(onChanged: (text){
                             title = text ;
               },
                 validator: (text)
                 {
                   if(text == null || text.isEmpty)
                     {
                       return 'Enter Task Title';
                     }
                   return null ;
                 },
                 decoration: InputDecoration(
                 labelText: AppLocalizations.of(context)!.add_new_task
           ),),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(onChanged: (text){
                 description = text ;
               },
                 validator: (text)
                 {
                   if(text == null || text.isEmpty)
                     {
                       return "Please Enter Description";
                     }
                   return null ;
                 },
                 decoration: InputDecoration(
                   labelText: 'Enter task description'
               ),
               maxLines: 4,),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(AppLocalizations.of(context)!.select_date,style:TextStyle(fontSize: 20,
                   fontWeight: FontWeight.w500,
                   color: AppColors.blackColor)),
             ),
             Text("7/7/2024",style:TextStyle(fontSize: 18,
                 fontWeight: FontWeight.w400,
                 color: AppColors.blackColor
             ),
             textAlign: TextAlign.center,) ,
             ElevatedButton(onPressed: (){
               addTask();
             }, child: Text(AppLocalizations.of(context)!.add,style:TextStyle(fontSize: 18,
                 fontWeight: FontWeight.bold,
                 color: AppColors.whiteColor
             )
             ))

           ],
         ))

       ],
      ),


    );
  }

  void addTask()
  {
    if(formKey.currentState?.validate()== true)
      {

      }
  }
}
