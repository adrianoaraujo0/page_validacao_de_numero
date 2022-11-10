import 'package:flutter/material.dart';

class ControllerHome{

 void createListControllerAndFocus(int quantidade,  List<FocusNode> listFocus, List<TextEditingController> listController){
    for(int i = 0; i < quantidade; i++){
      listFocus.add(FocusNode());
      listController.add(TextEditingController());
    }
  }

  void validationOnChanged(
    String value,
    FocusNode focusNode,
    FocusNode? beforeFocus,
    FocusNode? nextFocus,
    TextEditingController controller,
    TextEditingController beforeController,
    TextEditingController nextController){
      
    if(value.isEmpty && beforeFocus != null){
      beforeController.clear();
      beforeFocus.requestFocus();
    }else if(value.isNotEmpty && nextFocus != null){
      controller.text = value;
      nextController.clear();
      nextFocus.requestFocus();
    }else if(nextFocus == null && value.isNotEmpty){
      controller.text = value;
      focusNode.unfocus();
    }
  }
}