import 'package:finances/models/list/budget_list.dart';
import 'package:finances/models/budgets.dart';
import 'package:flutter/material.dart';

class AddPresupuestoPage extends StatefulWidget {
  AddPresupuestoPage({Key? key}) : super(key: key);

  @override
  _AddPresupuestoPageState createState() => _AddPresupuestoPageState();
}

class _AddPresupuestoPageState extends State<AddPresupuestoPage> {

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo presupuesto"),
        actions: [
          TextButton(onPressed: 
            (){
              _saveBudget();
              Navigator.pop(context);
            }, child: const Text("Guardar")),
        ],
      ),
      body: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                label:  Text("Nombre del presupuesto")
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.attach_money, size: 23,),
                labelText: "Valor"
              ),
            ),
            Text("Categoría"),
            // TODO: Hacer la página de añadir categorias
          ],
        ),
      ),
    );
  }

  _saveBudget(){
    double value = 0;
    if (valueController.text.isNotEmpty){
      value = double.parse(valueController.text);
    }
    final newBudget = Budget(nameController.text, value);
    budgetsList.add(newBudget);
  }
}