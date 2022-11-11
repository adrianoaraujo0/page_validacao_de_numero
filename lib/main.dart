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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 113, 22), elevation: 0,
        centerTitle: true,
        title: const Text(
          "Verificacao em duas etapas",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: const [
         Padding(
           padding: EdgeInsets.all(8.0),
           child: Icon(Icons.more_vert, color: Colors.grey, size: 30,),
         )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Digite um código de acesso de 6 digitos \n"
                "que será pedido quando você registrar \n" 
                "seu telefone no WhatsApp:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
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
      floatingActionButton: 
      ElevatedButton(
        onPressed: (() {}), 
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text("AVANÇAR"),
      ),
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
      
      return SizedBox(
      // margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 40,
      child: TextField(
        decoration: const InputDecoration(
          hintText: "*",
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
          )
        ),
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