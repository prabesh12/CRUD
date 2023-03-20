import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message, {bool showAction = false, Function? handleChange} ) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    action: showAction ? SnackBarAction(
      label: 'Undo',
      onPressed: (){
        if(handleChange != null){
           handleChange();
        }
      }
    ) : null,
  ));
}
