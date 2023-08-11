import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const titleApp = "Calculadora IMC";

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formeKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formeKey = GlobalKey<FormState>();
    });
  }


  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6){
        _infoText = "Imc ${imc.toStringAsPrecision(3)} está abaixo do Peso.";
      } else if (imc >= 18.6 && imc < 24.9){
        _infoText = "Imc ${imc.toStringAsPrecision(3)} está no peso ideal.";
      } else if (imc >= 24.9 && imc < 29.9){
        _infoText = "Imc ${imc.toStringAsPrecision(3)} está levemente acima peso.";
      } else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Imc ${imc.toStringAsPrecision(3)} está com obesidade grau I.";
      } else if (imc >= 34.9 && imc < 39.9){
        _infoText = "Imc ${imc.toStringAsPrecision(3)} está com obesidade grau II.";
      } else if (imc >= 40){
        _infoText = "Imc ${imc.toStringAsPrecision(3)} está com obesidade grau III.";
      };
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleApp),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formeKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 150.0,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                _infoText,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: weightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu peso!';
                  };
                },
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)",
                  hintText: "Peso em (Kg)",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Colors.lightBlue,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 25.0),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: heightController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua altura!';
                  };
                },
                decoration: const InputDecoration(
                  labelText: "Altura (cm)",
                  hintText: "Altura em (cm)",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Colors.lightBlue,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 25.0),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: (){
                  if(_formeKey.currentState!.validate()){
                    _calculate();
                  };
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300.0, 50.0),
                  backgroundColor: Colors.blueAccent,
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                child: const Text(
                  'Calcular',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
