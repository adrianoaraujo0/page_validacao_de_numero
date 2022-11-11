import 'controller.dart';
import 'package:flutter/material.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                listViewBuilder(6)
              ],
            ),
            const SizedBox( height: 50),
          ],
        ),
      ),
      floatingActionButton:  ElevatedButton(onPressed: (() {}), child: const Text("AVANÇAR")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget listViewBuilder(int quantidade){
    ControllerHome controllerHome = ControllerHome();

    List<FocusNode> listFocus = [];
    // ignore: unused_local_variable
    List<TextEditingController> listController = [];
    // ignore: unused_local_variable
    TextEditingController controller = TextEditingController();

    controllerHome.createListControllerAndFocus(quantidade, listFocus, listController);

  return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: quantidade,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if(index == 0){
            return buildTextField(
              controller: listController[index],
              nextController: listController[index + 1],
              focusNode: listFocus[index],
              autoFocus: true,
              nextFocus: listFocus[index + 1]
            );
          } else if(index == quantidade - 1){
            return buildTextField(
              controller: listController[index],
              beforeController: listController[index - 1],
              focusNode: listFocus[index],
              autoFocus: true,
              beforeFocus: listFocus[index - 1]
            );
          }
            return buildTextField(
              controller: listController[index],
              beforeController: listController[index - 1],
              nextController: listController[index + 1],
              focusNode: listFocus[index],
              autoFocus: true,
              nextFocus: listFocus[index + 1],
              beforeFocus: listFocus[index - 1]
            );
        }, 
      ),
    );
  }

  Widget buildTextField({
    required FocusNode focusNode,
    required bool autoFocus,
    required TextEditingController controller,
    TextEditingController? nextController,
    TextEditingController? beforeController,
    FocusNode? nextFocus,
    FocusNode? beforeFocus,
    })
    {
      
    ControllerHome controllerHome = ControllerHome();
      
      return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 50,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onTap: () => controller.clear(),
        onChanged: (value) {
          controllerHome.validationOnChanged(value, focusNode, beforeFocus, nextFocus, controller, beforeController, nextController);
        },
       autofocus: autoFocus,
       focusNode: focusNode,
      ),
    );
  }
}